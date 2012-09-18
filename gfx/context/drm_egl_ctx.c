/*  RetroArch - A frontend for libretro.
 *  Copyright (C) 2010-2012 - Hans-Kristian Arntzen
 *  Copyright (C) 2011-2012 - Daniel De Matteis
 * 
 *  RetroArch is free software: you can redistribute it and/or modify it under the terms
 *  of the GNU General Public License as published by the Free Software Found-
 *  ation, either version 3 of the License, or (at your option) any later version.
 *
 *  RetroArch is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 *  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
 *  PURPOSE.  See the GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License along with RetroArch.
 *  If not, see <http://www.gnu.org/licenses/>.
 */

// KMS/DRM context, running without any window manager.
// Based on kmscube example by Rob Clark.

#include "../../driver.h"
#include "../gfx_context.h"
#include "../gl_common.h"
#include "../gfx_common.h"

#ifdef HAVE_CONFIG_H
#include "../../config.h"
#endif

#include <errno.h>
#include <signal.h>
#include <stdint.h>
#include <signal.h>
#include <unistd.h>
#include <sched.h>
#include <sys/time.h>

#include <EGL/egl.h>
#include <EGL/eglext.h>

#include <libdrm/drm.h>
#include <xf86drm.h>
#include <xf86drmMode.h>
#include <gbm.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/poll.h>
#include <fcntl.h>

static EGLContext g_egl_ctx;
static EGLSurface g_egl_surf;
static EGLDisplay g_egl_dpy;
static EGLConfig g_config;

static volatile sig_atomic_t g_quit;
static bool g_inited;
static unsigned g_interval;

static struct gbm_device *g_gbm_dev;
static struct gbm_surface *g_gbm_surface;

static int g_drm_fd;
static drmModeModeInfo *g_drm_mode;
static uint32_t g_crtc_id;
static uint32_t g_connector_id;

static drmModeCrtcPtr g_orig_crtc;

static unsigned g_fb_width; // Just use something for now.
static unsigned g_fb_height;

static struct gbm_bo *g_bo, *g_next_bo;

static drmModeRes *g_resources;
static drmModeConnector *g_connector;
static drmModeEncoder *g_encoder;

struct drm_fb
{
   struct gbm_bo *bo;
   uint32_t fb_id;
};

static struct drm_fb *drm_fb_get_from_bo(struct gbm_bo *bo);

static void sighandler(int sig)
{
   (void)sig;
   g_quit = 1;
}

void gfx_ctx_set_swap_interval(unsigned interval, bool inited)
{
   g_interval = interval;
}

void gfx_ctx_check_window(bool *quit,
      bool *resize, unsigned *width, unsigned *height, unsigned frame_count)
{
   (void)frame_count;
   (void)width;
   (void)height;

   *resize = false;
   *quit   = g_quit;
}

static unsigned first_page_flip;
static unsigned last_page_flip;
static uint64_t first_usec;
static uint64_t last_usec;

static uint64_t flip_request_usec;

static unsigned missed_vblanks;
static unsigned hit_vblanks;

static void page_flip_handler(int fd, unsigned frame, unsigned sec, unsigned usec, void *data)
{
   (void)fd;

   uint64_t current_usec = (uint64_t)sec * 1000000 + usec;
   if (!first_page_flip)
   {
      first_page_flip = frame;
      first_usec      = current_usec;
   }

   if (last_page_flip)
   {
      unsigned missed = frame - last_page_flip - 1;
      if (!missed)
         hit_vblanks++;
      else
      {
         RARCH_LOG("[KMS/EGL]: Missed %u VBlank(s) (Frame: %u).\n",
               missed, frame - first_page_flip);
         missed_vblanks += missed;

         unsigned flip_time = current_usec - flip_request_usec;
         RARCH_LOG("\tDelta request => flip: %.5f ms.\n", flip_time / 1000.0);
      }
   }

   last_page_flip = frame;
   last_usec      = current_usec;

   *(bool*)data = false;
}

static bool waiting_for_flip;

static void wait_flip(bool block)
{
   struct pollfd fds = {0};
   fds.fd     = g_drm_fd;
   fds.events = POLLIN;

   drmEventContext evctx   = {0};
   evctx.version           = DRM_EVENT_CONTEXT_VERSION;
   evctx.page_flip_handler = page_flip_handler;
   
   int timeout = block ? -1 : 0;

   while (waiting_for_flip)
   {
      fds.revents = 0;
      if (poll(&fds, 1, timeout) < 0)
         break;

      if (fds.revents & (POLLHUP | POLLERR))
         break;

      if (fds.revents & POLLIN)
         drmHandleEvent(g_drm_fd, &evctx);
      else
         break;
   }

   if (!waiting_for_flip) // Page flip has taken place.
   {
      gbm_surface_release_buffer(g_gbm_surface, g_bo); // This buffer is not on-screen anymore. Release it to GBM.
      g_bo = g_next_bo; // This buffer is being shown now.
   }
}

static void queue_flip(void)
{
   g_next_bo = gbm_surface_lock_front_buffer(g_gbm_surface);
   struct drm_fb *fb = drm_fb_get_from_bo(g_next_bo);

   int ret = drmModePageFlip(g_drm_fd, g_crtc_id, fb->fb_id,
         DRM_MODE_PAGE_FLIP_EVENT, &waiting_for_flip);

   if (ret < 0)
   {
      RARCH_ERR("[KMS/EGL]: Failed to queue page flip.\n");
      return;
   }

   struct timeval tv;
   gettimeofday(&tv, NULL);
   flip_request_usec = (uint64_t)tv.tv_sec * 1000000 + tv.tv_usec;

   waiting_for_flip = true;
}

void gfx_ctx_swap_buffers(void)
{
   eglSwapBuffers(g_egl_dpy, g_egl_surf);

   // I guess we have to wait for flip to have taken place before another flip can be queued up.
   if (waiting_for_flip)
   {
      wait_flip(g_interval);
      if (waiting_for_flip) // We are still waiting for a flip (nonblocking mode, just drop the frame).
         return;
   }

   queue_flip();

   // We have to wait for this flip to finish. This shouldn't happen as we have triple buffered page-flips.
   if (!gbm_surface_has_free_buffers(g_gbm_surface))
   {
      RARCH_WARN("[KMS/EGL]: Triple buffering is not working correctly ...\n");
      wait_flip(true);  
   }
}

void gfx_ctx_set_resize(unsigned width, unsigned height)
{
   (void)width;
   (void)height;
}

void gfx_ctx_update_window_title(bool reset)
{
   (void)reset;
}

void gfx_ctx_get_video_size(unsigned *width, unsigned *height)
{
   *width  = g_fb_width;
   *height = g_fb_height;
}

#if 0
static void reschedule_process(void)
{
   struct sched_param param = {0};

   // All-out real-time. Why not? :D
   param.sched_priority = sched_get_priority_max(SCHED_FIFO);
   if (sched_setscheduler(0, SCHED_FIFO, &param) < 0)
      RARCH_ERR("[KMS/EGL]: Failed to set SCHED_FIFO priority.\n");

   int sched = sched_getscheduler(getpid());

   const char *scheduler;
   switch (sched)
   {
      case SCHED_OTHER:
         scheduler = "SCHED_OTHER";
         break;

      case SCHED_FIFO:
         scheduler = "SCHED_FIFO";
         break;

      default:
         scheduler = "Unrelated";
   }

   RARCH_LOG("[KMS/EGL]: Current scheduler: %s\n", scheduler);
   if (sched == SCHED_FIFO)
      RARCH_LOG("[KMS/EGL]: SCHED_FIFO prio: %d\n", param.sched_priority);
}
#endif

bool gfx_ctx_init(void)
{
   if (g_inited)
   {
      RARCH_ERR("[KMS/EGL]: Driver does not support reinitialization yet.\n");
      return false;
   }

#if 0
   reschedule_process();
#endif

   static const char *modules[] = {
      "i915", "radeon", "nouveau", "vmwgfx", "omapdrm", "exynos", NULL
   };

   for (int i = 0; modules[i]; i++)
   {
      RARCH_LOG("[KMS/EGL]: Trying to load module %s ...\n", modules[i]);
      g_drm_fd = drmOpen(modules[i], NULL);
      if (g_drm_fd >= 0)
      {
         RARCH_LOG("[KMS/EGL]: Found module %s.\n", modules[i]);
         break;
      }
   }

   if (g_drm_fd < 0)
   {
      RARCH_ERR("[KMS/EGL]: Couldn't open DRM device.\n");
      goto error;
   }

   g_resources = drmModeGetResources(g_drm_fd);
   if (!g_resources)
   {
      RARCH_ERR("[KMS/EGL]: Couldn't get device resources.\n");
      goto error;
   }

   for (int i = 0; i < g_resources->count_connectors; i++)
   {
      g_connector = drmModeGetConnector(g_drm_fd, g_resources->connectors[i]);
      if (g_connector->connection == DRM_MODE_CONNECTED)
         break;

      drmModeFreeConnector(g_connector);
      g_connector = NULL;
   }

   // TODO: Figure out what index for crtcs to use ...
   g_orig_crtc = drmModeGetCrtc(g_drm_fd, g_resources->crtcs[0]);
   if (!g_orig_crtc)
      RARCH_WARN("[KMS/EGL]: Cannot find original CRTC.\n");

   if (!g_connector)
   {
      RARCH_ERR("[KMS/EGL]: Couldn't get device connector.\n");
      goto error;
   }

   for (int i = 0, area = 0; i < g_connector->count_modes; i++)
   {
      drmModeModeInfo *current_mode = &g_connector->modes[i];
      int current_area = current_mode->hdisplay * current_mode->vdisplay;
      if (current_area > area)
      {
         g_drm_mode = current_mode;
         area       = current_area;
      }
   }

   if (!g_drm_mode)
   {
      RARCH_ERR("[KMS/EGL]: Couldn't find DRM mode.\n");
      goto error;
   }

	for (int i = 0; i < g_resources->count_encoders; i++)
   {
		g_encoder = drmModeGetEncoder(g_drm_fd, g_resources->encoders[i]);
		if (g_encoder->encoder_id == g_connector->encoder_id)
			break;

		drmModeFreeEncoder(g_encoder);
		g_encoder = NULL;
	}

	if (!g_encoder)
   {
      RARCH_ERR("[KMS/EGL]: Couldn't find DRM encoder.\n");
      goto error;
   }

	g_crtc_id      = g_encoder->crtc_id;
	g_connector_id = g_connector->connector_id;

   g_fb_width  = g_drm_mode->hdisplay;
   g_fb_height = g_drm_mode->vdisplay;

   g_gbm_dev     = gbm_create_device(g_drm_fd);
   g_gbm_surface = gbm_surface_create(g_gbm_dev,
         g_fb_width, g_fb_height,
         GBM_FORMAT_XRGB8888,
         GBM_BO_USE_SCANOUT | GBM_BO_USE_RENDERING);

   if (!g_gbm_surface)
   {
      RARCH_ERR("[KMS/EGL]: Couldn't create GBM surface.\n");
      goto error;
   }

   static const EGLint context_attribs[] = {
      EGL_CONTEXT_CLIENT_VERSION, 2,
      EGL_NONE
   };

   static const EGLint config_attribs[] = {
      EGL_SURFACE_TYPE,    EGL_WINDOW_BIT,
      EGL_RED_SIZE,        1,
      EGL_GREEN_SIZE,      1,
      EGL_BLUE_SIZE,       1,
      EGL_ALPHA_SIZE,      0,
#ifdef HAVE_OPENGLES2
      EGL_RENDERABLE_TYPE, EGL_OPENGL_ES2_BIT,
#else
      EGL_RENDERABLE_TYPE, EGL_OPENGL_BIT,
#endif
      EGL_NONE
   };

   g_egl_dpy = eglGetDisplay((EGLNativeDisplayType)g_gbm_dev);
   if (!g_egl_dpy)
   {
      RARCH_ERR("[KMS/EGL]: Couldn't get EGL display.\n");
      goto error;
   }

   EGLint major, minor;
   if (!eglInitialize(g_egl_dpy, &major, &minor))
      goto error;

#ifdef HAVE_OPENGLES2
   RARCH_LOG("[KMS/EGL]: Using OpenGL ES API.\n");
   if (!eglBindAPI(EGL_OPENGL_ES_API))
      goto error;
#else
   RARCH_LOG("[KMS/EGL]: Using OpenGL API.\n");
   if (!eglBindAPI(EGL_OPENGL_API))
      goto error;
#endif

   EGLint n;
   if (!eglChooseConfig(g_egl_dpy, config_attribs, &g_config, 1, &n) || n != 1)
      goto error;

   g_egl_ctx = eglCreateContext(g_egl_dpy, g_config, EGL_NO_CONTEXT, context_attribs);
   if (!g_egl_ctx)
      goto error;

   g_egl_surf = eglCreateWindowSurface(g_egl_dpy, g_config, (EGLNativeWindowType)g_gbm_surface, NULL);
   if (!g_egl_surf)
      goto error;

   if (!eglMakeCurrent(g_egl_dpy, g_egl_surf, g_egl_surf, g_egl_ctx))
      goto error;

   return true;

error:
   gfx_ctx_destroy();
   return false;
}

static void drm_fb_destroy_callback(struct gbm_bo *bo, void *data)
{
   struct drm_fb *fb      = (struct drm_fb*)data;

   if (fb->fb_id)
      drmModeRmFB(g_drm_fd, fb->fb_id);

   free(fb);
}

static struct drm_fb *drm_fb_get_from_bo(struct gbm_bo *bo)
{
   struct drm_fb *fb = (struct drm_fb*)gbm_bo_get_user_data(bo);
   if (fb)
      return fb;

   fb = (struct drm_fb*)calloc(1, sizeof(*fb));
   fb->bo = bo;

   unsigned width  = gbm_bo_get_width(bo);
   unsigned height = gbm_bo_get_height(bo);
   unsigned stride = gbm_bo_get_stride(bo);
   unsigned handle = gbm_bo_get_handle(bo).u32;

   int ret = drmModeAddFB(g_drm_fd, width, height, 24, 32, stride, handle, &fb->fb_id);
   if (ret < 0)
   {
      RARCH_ERR("[KMS/EGL]: Failed to create FB: %s\n", strerror(errno));
      free(fb);
      return NULL;
   }

   gbm_bo_set_user_data(bo, fb, drm_fb_destroy_callback);
   return fb;
}

bool gfx_ctx_set_video_mode(
      unsigned width, unsigned height,
      unsigned bits, bool fullscreen)
{
   (void)bits;
   if (g_inited)
      return false;

   struct sigaction sa = {{0}};
   sa.sa_handler = sighandler;
   sa.sa_flags   = SA_RESTART;
   sigemptyset(&sa.sa_mask);
   sigaction(SIGINT, &sa, NULL);
   sigaction(SIGTERM, &sa, NULL);

   glClearColor(0.0, 0.0, 0.0, 1.0);
   glClear(GL_COLOR_BUFFER_BIT);
   eglSwapBuffers(g_egl_dpy, g_egl_surf);

   g_bo = gbm_surface_lock_front_buffer(g_gbm_surface);
   struct drm_fb *fb = drm_fb_get_from_bo(g_bo);

   int ret = drmModeSetCrtc(g_drm_fd, g_crtc_id, fb->fb_id, 0, 0, &g_connector_id, 1, g_drm_mode);
   if (ret < 0)
      goto error;

   g_inited = true;
   return true;

error:
   gfx_ctx_destroy();
   return false;
}

void gfx_ctx_destroy(void)
{
   if (g_egl_dpy)
   {
      if (g_egl_ctx)
      {
         eglMakeCurrent(g_egl_dpy, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
         eglDestroyContext(g_egl_dpy, g_egl_ctx);
      }

      if (g_egl_surf)
         eglDestroySurface(g_egl_dpy, g_egl_surf);
      eglTerminate(g_egl_dpy);
   }

   // Be as careful as possible in deinit.
   // If we screw up, the KMS tty will not restore.

   g_egl_ctx  = NULL;
   g_egl_surf = NULL;
   g_egl_dpy  = NULL;
   g_config   = 0;

   // Restore original CRTC.
   if (g_orig_crtc)
   {
      drmModeSetCrtc(g_drm_fd, g_orig_crtc->crtc_id,
            g_orig_crtc->buffer_id,
            g_orig_crtc->x,
            g_orig_crtc->y,
            &g_connector_id, 1, &g_orig_crtc->mode);

      drmModeFreeCrtc(g_orig_crtc);
   }

   if (g_gbm_surface)
      gbm_surface_destroy(g_gbm_surface);

   if (g_gbm_dev)
      gbm_device_destroy(g_gbm_dev);

   if (g_encoder)
      drmModeFreeEncoder(g_encoder);

   if (g_connector)
      drmModeFreeConnector(g_connector);

   if (g_resources)
      drmModeFreeResources(g_resources);

   g_gbm_surface = NULL;
   g_gbm_dev     = NULL;
   g_encoder     = NULL;
   g_connector   = NULL;
   g_resources   = NULL;
   g_orig_crtc   = NULL;

   g_quit         = 0;
   g_crtc_id      = 0;
   g_connector_id = 0;

   g_fb_width  = 0;
   g_fb_height = 0;

   // TODO: Do we have to free this?
   g_bo = NULL;

   drmClose(g_drm_fd);
   g_drm_fd = -1;

   unsigned frames = last_page_flip - first_page_flip;
   if (frames)
   {
      uint64_t usec = last_usec - first_usec;
      RARCH_WARN("[KMS/EGL]: Estimated monitor FPS: %.5f Hz\n", 1000000.0 * frames / usec); 
   }

   RARCH_WARN("[KMS/EGL]: Performance stats: Missed VBlanks: %u, Perfect VBlanks: %u\n", 
         missed_vblanks, hit_vblanks);

   // Reinitialization fails for now ...
   //g_inited = false;
}

void gfx_ctx_input_driver(const input_driver_t **input, void **input_data)
{
   void *linuxinput = input_linuxraw.init();
   *input           = linuxinput ? &input_linuxraw : NULL;
   *input_data      = linuxinput;
}

void gfx_ctx_set_projection(gl_t *gl, const struct gl_ortho *ortho, bool allow_rotate)
{
   // Calculate projection.
   math_matrix proj;
   matrix_ortho(&proj, ortho->left, ortho->right,
         ortho->bottom, ortho->top, ortho->znear, ortho->zfar);

   if (allow_rotate)
   {
      math_matrix rot;
      matrix_rotate_z(&rot, M_PI * gl->rotation / 180.0f);
      matrix_multiply(&proj, &rot, &proj);
   }

   gl->mvp = proj;
}

bool gfx_ctx_window_has_focus(void)
{
   return g_inited;
}

gfx_ctx_proc_t gfx_ctx_get_proc_address(const char *symbol)
{
   return eglGetProcAddress(symbol);
}

