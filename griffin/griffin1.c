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
//#include "../gfx/video_shader_parse.c"
//#include "../gfx/drivers_shader/shader_null.c"

