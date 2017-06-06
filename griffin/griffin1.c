/* RetroArch - A frontend for libretro.
* Copyright (C) 2010-2014 - Hans-Kristian Arntzen
* Copyright (C) 2011-2017 - Daniel De Matteis
*
* RetroArch is free software: you can redistribute it and/or modify it under the terms
* of the GNU General Public License as published by the Free Software Found-
* ation, either version 3 of the License, or (at your option) any later version.
*
* RetroArch is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
* without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
* PURPOSE. See the GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along with RetroArch.
* If not, see <http://www.gnu.org/licenses/>.
*/

#if defined(HAVE_CG) || defined(HAVE_HLSL) || defined(HAVE_GLSL)
#define HAVE_SHADERS
#endif

#if defined(HAVE_ZLIB) || defined(HAVE_7ZIP)
#define HAVE_COMPRESSION
#endif

#include <compat/posix_string.h>

#if _MSC_VER
#include "../libretro-common/compat/compat_snprintf.c"
#endif

#include "../verbosity.c"

#if defined(HAVE_LOGGER) && !defined(ANDROID)
#include "../network/net_logger.c"
#endif

/*============================================================
CONSOLE EXTENSIONS
============================================================ */
#ifdef RARCH_CONSOLE

#ifdef HW_DOL
#include "../memory/ngc/ssaram.c"
#endif

#endif

/*============================================================
ALGORITHMS
============================================================ */

/*============================================================
ARCHIVE FILE
============================================================ */
#include "../libretro-common/file/archive_file.c"

#ifdef HAVE_ZLIB
#include "../libretro-common/file/archive_file_zlib.c"
#endif

#ifdef HAVE_7ZIP
#include "../libretro-common/file/archive_file_7z.c"
#endif

/*============================================================
COMPRESSION
============================================================ */
#include "../libretro-common/streams/stdin_stream.c"
#include "../libretro-common/streams/trans_stream.c"
#include "../libretro-common/streams/trans_stream_pipe.c"

#ifdef HAVE_ZLIB
#include "../libretro-common/streams/trans_stream_zlib.c"
#endif

/*============================================================
ENCODINGS
============================================================ */
#include "../libretro-common/encodings/encoding_utf.c"
#include "../libretro-common/encodings/encoding_crc32.c"

/*============================================================
PERFORMANCE
============================================================ */
#include "../libretro-common/features/features_cpu.c"
#include "../performance_counters.c"

/*============================================================
COMPATIBILITY
============================================================ */
#ifndef HAVE_GETOPT_LONG
#include "../compat/compat_getopt.c"
#endif

#ifndef HAVE_STRCASESTR
#include "../compat/compat_strcasestr.c"
#endif

#ifndef HAVE_STRL
#include "../compat/compat_strl.c"
#endif

#if defined(_WIN32) && !defined(_XBOX)
#include "../compat/compat_posix_string.c"
#endif

#if defined(WANT_IFADDRS)
#include "../compat/compat_ifaddrs.c"
#endif

#include "../libretro-common/compat/compat_fnmatch.c"
#include "../libretro-common/memmap/memalign.c"

/*============================================================
CONFIG FILE
============================================================ */
#if defined(_MSC_VER)
#undef __LIBRETRO_SDK_COMPAT_POSIX_STRING_H
#undef __LIBRETRO_SDK_COMPAT_MSVC_H
#undef strcasecmp
#endif

#include "../libretro-common/file/config_file.c"
#include "../libretro-common/file/config_file_userdata.c"
#include "../managers/core_manager.c"
#include "../managers/core_option_manager.c"

/*============================================================
ACHIEVEMENTS
============================================================ */
#if defined(HAVE_CHEEVOS) && defined(HAVE_THREADS)
#if !defined(HAVE_NETWORKING)
#include "../libretro-common/net/net_http.c"
#endif

#include "../libretro-common/formats/json/jsonsax.c"
#include "../network/net_http_special.c"
#include "../cheevos/cheevos.c"
#endif

/*============================================================
MD5
============================================================ */
#if (defined(HAVE_CHEEVOS) && defined(HAVE_THREADS)) || (defined(HAVE_HTTPSERVER) && defined(HAVE_ZLIB))
#include "../libretro-common/utils/md5.c"
#endif

/*============================================================
CHEATS
============================================================ */
#include "../managers/cheat_manager.c"
#include "../libretro-common/hash/rhash.c"

/*============================================================
VIDEO CONTEXT
============================================================ */
#include "../gfx/drivers_context/gfx_null_ctx.c"

#if defined(__CELLOS_LV2__)
#include "../gfx/drivers_context/ps3_ctx.c"
#elif defined(ANDROID)
#include "../gfx/drivers_context/android_ctx.c"
#elif defined(__QNX__)
#include "../gfx/drivers_context/qnx_ctx.c"
#elif defined(EMSCRIPTEN)
#include "../gfx/drivers_context/emscriptenegl_ctx.c"
#elif defined(__APPLE__) && !defined(TARGET_IPHONE_SIMULATOR) && !defined(TARGET_OS_IPHONE)
#include "../gfx/drivers_context/cgl_ctx.c"
#endif


#if defined(HAVE_VIVANTE_FBDEV)
#include "../gfx/drivers_context/vivante_fbdev_ctx.c"
#endif

#if defined(HAVE_OPENDINGUX_FBDEV)
#include "../gfx/drivers_context/opendingux_fbdev_ctx.c"
#endif

#ifdef HAVE_WAYLAND
#include "../gfx/drivers_context/wayland_ctx.c"
#endif

#ifdef HAVE_DRM
#include "../gfx/common/drm_common.c"
#endif

#ifdef HAVE_VULKAN
#include "../gfx/common/vulkan_common.c"
#include "../libretro-common/vulkan/vulkan_symbol_wrapper.c"
#ifdef HAVE_VULKAN_DISPLAY
#include "../gfx/drivers_context/khr_display_ctx.c"
#endif
#endif

#if defined(HAVE_KMS)
#include "../gfx/drivers_context/drm_ctx.c"
#endif

#if defined(HAVE_EGL)
#include "../gfx/common/egl_common.c"

#if defined(HAVE_VIDEOCORE)
#include "../gfx/drivers_context/vc_egl_ctx.c"
#endif

#endif

#if defined(HAVE_X11)
#include "../gfx/common/x11_common.c"
#include "../gfx/common/dbus_common.c"
#include "../gfx/common/xinerama_common.c"

#ifndef HAVE_OPENGLES
#include "../gfx/drivers_context/x_ctx.c"
#endif

#ifdef HAVE_EGL
#include "../gfx/drivers_context/xegl_ctx.c"
#endif

#endif

/*============================================================
VIDEO SHADERS
============================================================ */
#include "../gfx/video_shader_parse.c"
#include "../gfx/drivers_shader/shader_null.c"

#ifdef HAVE_CG
#ifdef HAVE_OPENGL
#include "../gfx/drivers_shader/shader_gl_cg.c"
#endif
#endif

#ifdef HAVE_HLSL
#include "../gfx/drivers_shader/shader_hlsl.c"
#endif

#ifdef HAVE_GLSL
#include "../gfx/drivers_shader/shader_glsl.c"
#endif

/*============================================================
VIDEO IMAGE
============================================================ */

#include "../libretro-common/formats/image_texture.c"

#ifdef HAVE_RTGA
#include "../libretro-common/formats/tga/rtga.c"
#endif

#ifdef HAVE_IMAGEVIEWER
#include "../cores/libretro-imageviewer/image_core.c"
#endif

#include "../libretro-common/formats/image_transfer.c"
#ifdef HAVE_RPNG
#include "../libretro-common/formats/png/rpng.c"
#include "../libretro-common/formats/png/rpng_encode.c"
#endif
#ifdef HAVE_RJPEG
#include "../libretro-common/formats/jpeg/rjpeg.c"
#endif
#ifdef HAVE_RBMP
#include "../libretro-common/formats/bmp/rbmp.c"
#include "../libretro-common/formats/bmp/rbmp_encode.c"
#endif

#include "../libretro-common/formats/wav/rwav.c"

/*============================================================
VIDEO DRIVER
============================================================ */

#if defined(GEKKO)
#ifdef HW_RVL
#include "../gfx/drivers/gx_gfx_vi_encoder.c"
#include "../memory/wii/mem2_manager.c"
#endif
#endif

#ifdef HAVE_SDL2
#include "../gfx/drivers/sdl2_gfx.c"
#endif

#ifdef HAVE_VG
#include "../gfx/drivers/vg.c"
#endif

#ifdef HAVE_OMAP
#include "../gfx/drivers/omap_gfx.c"
#endif

#ifdef HAVE_VULKAN
#include "../gfx/drivers/vulkan.c"
#endif

#if defined(HAVE_PLAIN_DRM)
#include "../gfx/drivers/drm_gfx.c"
#endif

#include "../gfx/video_renderchain_driver.c"
#include "../gfx/drivers_renderchain/null_renderchain.c"

#ifdef HAVE_OPENGL
#include "../gfx/common/gl_common.c"
#include "../gfx/drivers/gl.c"
#include "../libretro-common/gfx/gl_capabilities.c"
#include "../gfx/drivers_renderchain/gl_legacy_renderchain.c"

#ifndef HAVE_PSGL
#include "../libretro-common/glsym/rglgen.c"
#if defined(HAVE_OPENGLES2)
#include "../libretro-common/glsym/glsym_es2.c"
#elif defined(HAVE_OPENGLES3)
#include "../libretro-common/glsym/glsym_es3.c"
#else
#include "../libretro-common/glsym/glsym_gl.c"
#endif
#endif

#endif

#ifdef HAVE_XVIDEO
#include "../gfx/drivers/xvideo.c"
#endif

#if defined(GEKKO)
#include "../gfx/drivers/gx_gfx.c"
#elif defined(PSP)
#include "../gfx/drivers/psp1_gfx.c"
#elif defined(HAVE_VITA2D)
#include "../deps/libvita2d/source/vita2d.c"
#include "../deps/libvita2d/source/vita2d_texture.c"
#include "../deps/libvita2d/source/vita2d_draw.c"
#include "../deps/libvita2d/source/utils.c"

#include "../gfx/drivers/vita2d_gfx.c"
#elif defined(_3DS)
#include "../gfx/drivers/ctr_gfx.c"
#elif defined(XENON)
#include "../gfx/drivers/xenon360_gfx.c"
#elif defined(DJGPP)
#include "../gfx/drivers/vga_gfx.c"
#endif
#include "../gfx/drivers/nullgfx.c"

#if defined(_WIN32) && !defined(_XBOX)
#include "../gfx/drivers/gdi_gfx.c"
#endif

/*============================================================
FONTS
============================================================ */

#include "../gfx/drivers_font_renderer/bitmapfont.c"
#include "../gfx/font_driver.c"

#if defined(HAVE_STB_FONT)
#include "../gfx/drivers_font_renderer/stb_unicode.c"
#include "../gfx/drivers_font_renderer/stb.c"
#endif

#if defined(HAVE_FREETYPE)
#include "../gfx/drivers_font_renderer/freetype.c"
#endif

#if defined(__APPLE__) && defined(HAVE_CORETEXT)
#include "../gfx/drivers_font_renderer/coretext.c"
#endif

#if defined(HAVE_LIBDBGFONT)
#include "../gfx/drivers_font/ps_libdbgfont.c"
#endif

#if defined(HAVE_OPENGL)
#include "../gfx/drivers_font/gl_raster_font.c"
#endif

#if defined(_XBOX1)
#include "../gfx/drivers_font/xdk1_xfonts.c"
#endif

#if defined(VITA)
#include "../gfx/drivers_font/vita2d_font.c"
#endif

#if defined(_3DS)
#include "../gfx/drivers_font/ctr_font.c"
#endif

#if defined(WIIU)
#include "../gfx/drivers_font/wiiu_font.c"
#endif

#if defined(HAVE_CACA)
#include "../gfx/drivers_font/caca_font.c"
#endif

#if defined(DJGPP)
#include "../gfx/drivers_font/vga_font.c"
#endif

#if defined(_WIN32) && !defined(_XBOX)
#include "../gfx/drivers_font/gdi_font.c"
#endif

#if defined(HAVE_VULKAN)
#include "../gfx/drivers_font/vulkan_raster_font.c"
#endif


/*============================================================
INPUT
============================================================ */
//#include "../tasks/task_autodetect.c"
//#include "../tasks/task_audio_mixer.c"
//#include "../input/input_joypad_driver.c"
//#include "../input/input_config.c"
//#include "../input/input_keymaps.c"
//#include "../input/input_remapping.c"
//#include "../input/input_keyboard.c"
//
//#ifdef HAVE_OVERLAY
//#include "../input/input_overlay.c"
//#include "../tasks/task_overlay.c"
//#endif

//#ifdef HAVE_X11
//#include "../input/common/x11_input_common.c"
//#endif

//#if defined(_WIN32) && !defined(_XBOX) && _WIN32_WINNT >= 0x0501
///* winraw only available since XP */
//#include "../input/drivers/winraw_input.c"
//#endif

//#include "../input/input_autodetect_builtin.c"

//#if defined(__CELLOS_LV2__)
//#include "../input/drivers/ps3_input.c"
//#include "../input/drivers_joypad/ps3_joypad.c"
//#elif defined(SN_TARGET_PSP2) || defined(PSP) || defined(VITA)
//#include "../input/drivers/psp_input.c"
//#include "../input/drivers_joypad/psp_joypad.c"
//#elif defined(HAVE_COCOA) || defined(HAVE_COCOATOUCH)
//#include "../input/drivers/cocoa_input.c"
//#elif defined(_3DS)
//#include "../input/drivers/ctr_input.c"
//#include "../input/drivers_joypad/ctr_joypad.c"
//#elif defined(GEKKO)
//#include "../input/drivers/gx_input.c"
//#include "../input/drivers_joypad/gx_joypad.c"
//#elif defined(_XBOX)
//#include "../input/drivers/xdk_xinput_input.c"
//#include "../input/drivers_joypad/xdk_joypad.c"
//#elif defined(XENON)
//#include "../input/drivers/xenon360_input.c"
//#elif defined(ANDROID)
//#include "../input/drivers/android_input.c"
//#include "../input/drivers_keyboard/keyboard_event_android.c"
//#include "../input/drivers_joypad/android_joypad.c"
//#elif defined(__QNX__)
//#include "../input/drivers/qnx_input.c"
//#include "../input/drivers_joypad/qnx_joypad.c"
//#elif defined(EMSCRIPTEN)
//#include "../input/drivers/rwebinput_input.c"
//#elif defined(DJGPP)
//#include "../input/drivers/dos_input.c"
//#include "../input/drivers_joypad/dos_joypad.c"
//#endif

//#ifdef HAVE_DINPUT
//oo
//#include "../input/drivers/dinput.c"
//#include "../input/drivers_joypad/dinput_joypad.c"
//#endif

//#ifdef HAVE_XINPUT
//oo
//#include "../input/drivers_joypad/xinput_joypad.c"
//#endif

//#if defined(__linux__) && !defined(ANDROID)
//oo
//#include "../input/common/linux_common.c"
//#include "../input/common/epoll_common.c"
//#include "../input/drivers/linuxraw_input.c"
//#include "../input/drivers_joypad/linuxraw_joypad.c"
//#endif

//#ifdef HAVE_X11
//oo
//#include "../input/drivers/x11_input.c"
//#endif

//#ifdef HAVE_UDEV
//oo
//#include "../input/common/udev_common.c"
//#include "../input/drivers/udev_input.c"
//#include "../input/drivers_joypad/udev_joypad.c"
//#endif

//#include "../input/drivers/nullinput.c"
//#include "../input/drivers_joypad/null_joypad.c"

/*============================================================
INPUT (HID)
============================================================ */
//#ifdef HAVE_HID
//oo
//#include "../input/input_hid_driver.c"
//#include "../input/drivers_joypad/hid_joypad.c"
//#include "../input/drivers_hid/null_hid.c"
//
//#if defined(HAVE_LIBUSB) && defined(HAVE_THREADS)
//#include "../input/drivers_hid/libusb_hid.c"
//#endif
//
//#ifdef HAVE_BTSTACK
//#include "../input/drivers_hid/btstack_hid.c"
//#endif
//
//#if defined(__APPLE__) && defined(HAVE_IOHIDMANAGER)
//#include "../input/drivers_hid/iohidmanager_hid.c"
//#endif
//
//#ifdef HAVE_WIIUSB_HID
//#include "../input/drivers_hid/wiiusb_hid.c"
//#endif
//
//#include "../input/connect/joypad_connection.c"
//#include "../input/connect/connect_ps3.c"
//#include "../input/connect/connect_ps4.c"
//#include "../input/connect/connect_wii.c"
//#include "../input/connect/connect_wiiupro.c"
//#include "../input/connect/connect_snesusb.c"
//#include "../input/connect/connect_nesusb.c"
//#include "../input/connect/connect_wiiugca.c"
//#include "../input/connect/connect_ps2adapter.c"
//#endif

/*============================================================
 KEYBOARD EVENT
 ============================================================ */

#ifdef __APPLE__
oo
#include "../input/drivers_keyboard/keyboard_event_apple.c"
#endif

#ifdef HAVE_XKBCOMMON
oo
#include "../input/drivers_keyboard/keyboard_event_xkb.c"
#endif

/*============================================================
STATE TRACKER
============================================================ */
//#include "../gfx/video_state_tracker.c"

//#ifdef HAVE_PYTHON
//oo
//#include "../gfx/drivers_tracker/video_state_python.c"
//#endif

