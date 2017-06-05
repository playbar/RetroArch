LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

RARCH_DIR := ../../../..

HAVE_NEON   := 1
HAVE_LOGGER := 0
HAVE_VULKAN := 1

INCFLAGS    :=
DEFINES     :=

LIBRETRO_COMM_DIR := $(RARCH_DIR)/libretro-common
DEPS_DIR          := $(RARCH_DIR)/deps

GIT_VERSION := $(shell git rev-parse --short HEAD 2>/dev/null)
ifneq ($(GIT_VERSION),)
   DEFINES += -DHAVE_GIT_VERSION -DGIT_VERSION=$(GIT_VERSION)
endif

include $(CLEAR_VARS)
ifeq ($(TARGET_ARCH),arm)
   DEFINES += -DANDROID_ARM -marm
   LOCAL_ARM_MODE := arm
endif

ifeq ($(TARGET_ARCH),x86)
   DEFINES += -DANDROID_X86 -DHAVE_SSSE3
endif

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)

ifeq ($(HAVE_NEON),1)
	DEFINES += -D__ARM_NEON__
   LOCAL_SRC_FILES += $(LIBRETRO_COMM_DIR)/audio/conversion/s16_to_float_neon.S.neon \
					  $(LIBRETRO_COMM_DIR)/audio/conversion/float_to_s16_neon.S.neon \
					  $(LIBRETRO_COMM_DIR)/audio/resampler/drivers/sinc_resampler_neon.S.neon \
					  $(RARCH_DIR)/audio/drivers_resampler/cc_resampler_neon.S.neon
endif
DEFINES += -DSINC_LOWER_QUALITY
DEFINES += -DANDROID_ARM_V7
endif

ifeq ($(TARGET_ARCH),mips)
   DEFINES += -DANDROID_MIPS -D__mips__ -D__MIPSEL__
endif

LOCAL_MODULE := retroarch-activity

LOCAL_SRC_FILES  +=	\
                    $(RARCH_DIR)/griffin/griffin_back.c \
                    $(RARCH_DIR)/menu/menu_driver.c \
                    $(RARCH_DIR)/menu/menu_input.c \
                    $(RARCH_DIR)/menu/menu_event.c \
                    $(RARCH_DIR)/menu/menu_entries.c \
                    $(RARCH_DIR)/menu/menu_setting.c \
                    $(RARCH_DIR)/menu/menu_cbs.c \
                    $(RARCH_DIR)/menu/menu_content.c \
                    $(RARCH_DIR)/menu/widgets/menu_entry.c \
                    $(RARCH_DIR)/menu/widgets/menu_filebrowser.c \
                    $(RARCH_DIR)/menu/widgets/menu_dialog.c \
                    $(RARCH_DIR)/menu/widgets/menu_input_dialog.c \
                    $(RARCH_DIR)/menu/widgets/menu_input_bind_dialog.c \
                    $(RARCH_DIR)/menu/widgets/menu_list.c \
                    $(RARCH_DIR)/menu/widgets/menu_osk.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_ok.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_cancel.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_select.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_start.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_info.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_refresh.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_left.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_right.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_title.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_deferred_push.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_scan.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_get_value.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_label.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_sublabel.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_up.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_down.c \
                    $(RARCH_DIR)/menu/cbs/menu_cbs_contentlist_switch.c \
                    $(RARCH_DIR)/menu/menu_shader.c \
                    $(RARCH_DIR)/menu/menu_displaylist.c \
                    $(RARCH_DIR)/menu/menu_animation.c \
                    $(RARCH_DIR)/menu/drivers/null.c \
                    $(RARCH_DIR)/menu/drivers/menu_generic.c \
                    $(RARCH_DIR)/menu/drivers_display/menu_display_null.c \
                    $(RARCH_DIR)/menu/drivers_display/menu_display_gl.c \
                    $(RARCH_DIR)/menu/drivers_display/menu_display_vulkan.c \
                    $(RARCH_DIR)/menu/drivers/rgui.c \
                    $(RARCH_DIR)//menu/drivers/xmb.c \
                    $(RARCH_DIR)/menu/drivers/materialui.c \
                    $(RARCH_DIR)/input/input_remote.c \
                    $(RARCH_DIR)/cores/libretro-net-retropad/net_retropad_core.c \
                    $(RARCH_DIR)/command.c \
                    $(RARCH_DIR)/libretro-common/net/net_http_parse.c \
                    $(RARCH_DIR)/deps/7zip/7zIn.c \
                    $(RARCH_DIR)/deps/7zip/7zAlloc.c \
                    $(RARCH_DIR)/deps/7zip/Bra86.c \
                    $(RARCH_DIR)/deps/7zip/7zFile.c \
                    $(RARCH_DIR)/deps/7zip/7zStream.c \
                    $(RARCH_DIR)/deps/7zip/7zBuf2.c \
                    $(RARCH_DIR)/deps/7zip/LzmaDec.c \
                    $(RARCH_DIR)/deps/7zip/7zCrcOpt.c \
                    $(RARCH_DIR)/deps/7zip/Bra.c \
                    $(RARCH_DIR)/deps/7zip/7zDec.c \
                    $(RARCH_DIR)/deps/7zip/Bcj2.c \
                    $(RARCH_DIR)/deps/7zip/7zCrc.c \
                    $(RARCH_DIR)/deps/7zip/Lzma2Dec.c \
                    $(RARCH_DIR)/deps/7zip/7zBuf.c \
                    $(RARCH_DIR)/libretro-common/audio/conversion/s16_to_float.c \
                    $(RARCH_DIR)/libretro-common/audio/conversion/float_to_s16.c \
                    $(RARCH_DIR)/libretro-common/audio/audio_mix.c \
                    $(RARCH_DIR)/libretro-db/bintree.c \
                    $(RARCH_DIR)/libretro-db/libretrodb.c \
                    $(RARCH_DIR)/libretro-db/rmsgpack.c \
                    $(RARCH_DIR)/libretro-db/rmsgpack_dom.c \
                    $(RARCH_DIR)/libretro-db/query.c \
                    $(RARCH_DIR)/database_info.c \
                    $(RARCH_DIR)/deps/miniupnpc/igd_desc_parse.c \
                    $(RARCH_DIR)/deps/miniupnpc/upnpreplyparse.c \
                    $(RARCH_DIR)/deps/miniupnpc/upnpcommands.c \
                    $(RARCH_DIR)/deps/miniupnpc/upnperrors.c \
                    $(RARCH_DIR)/deps/miniupnpc/connecthostport.c \
                    $(RARCH_DIR)/deps/miniupnpc/portlistingparse.c \
                    $(RARCH_DIR)/deps/miniupnpc/receivedata.c \
                    $(RARCH_DIR)/deps/miniupnpc/upnpdev.c \
                    $(RARCH_DIR)/deps/miniupnpc/minissdpc.c \
                    $(RARCH_DIR)/deps/miniupnpc/miniwget.c \
                    $(RARCH_DIR)/deps/miniupnpc/miniupnpc.c \
                    $(RARCH_DIR)/deps/miniupnpc/minixml.c \
                    $(RARCH_DIR)/deps/miniupnpc/minisoap.c \
					$(RARCH_DIR)/griffin/griffin_cpp.cpp \


ifeq ($(HAVE_LOGGER), 1)
   DEFINES += -DHAVE_LOGGER
endif
LOGGER_LDLIBS := -llog

ifeq ($(GLES),3)
   GLES_LIB := -lGLESv3
   DEFINES += -DHAVE_OPENGLES3
else
   GLES_LIB := -lGLESv2
   DEFINES += -DHAVE_OPENGLES2
endif

DEFINES += -DRARCH_MOBILE -DHAVE_GRIFFIN -DHAVE_STB_VORBIS -DHAVE_LANGEXTRA -DANDROID -DHAVE_DYNAMIC -DHAVE_OPENGL -DHAVE_FBO -DHAVE_OVERLAY -DHAVE_OPENGLES -DGLSL_DEBUG -DHAVE_DYLIB -DHAVE_EGL -DHAVE_GLSL -DHAVE_MENU -DHAVE_RGUI -DHAVE_ZLIB -DHAVE_RPNG -DHAVE_RJPEG -DHAVE_RBMP -DHAVE_RTGA -DINLINE=inline -DHAVE_THREADS -D__LIBRETRO__ -DHAVE_RSOUND -DHAVE_NETWORKGAMEPAD -DHAVE_NETWORKING -DRARCH_INTERNAL -DHAVE_FILTERS_BUILTIN -DHAVE_MATERIALUI -DHAVE_XMB -DHAVE_SHADERPIPELINE -DHAVE_LIBRETRODB -DHAVE_STB_FONT -DHAVE_IMAGEVIEWER -DHAVE_UPDATE_ASSETS -DHAVE_CC_RESAMPLER -DHAVE_MINIUPNPC -DHAVE_BUILTINMINIUPNPC -DMINIUPNPC_SET_SOCKET_TIMEOUT -DMINIUPNPC_GET_SRC_ADDR
DEFINES += -DWANT_IFADDRS

ifeq ($(HAVE_VULKAN),1)
DEFINES += -DHAVE_VULKAN
endif
DEFINES += -DHAVE_7ZIP
DEFINES += -DHAVE_CHEEVOS
DEFINES += -DHAVE_SL

LOCAL_CFLAGS   += -Wall -std=gnu99 -pthread -Wno-unused-function -fno-stack-protector -funroll-loops $(DEFINES)
LOCAL_CPPFLAGS := -fexceptions -fpermissive -std=gnu++11 -fno-rtti -Wno-reorder $(DEFINES)

# Let ndk-build set the optimization flags but remove -O3 like in cf3c3
LOCAL_CFLAGS := $(subst -O3,-O2,$(LOCAL_CFLAGS))

LOCAL_LDLIBS	:= -L$(SYSROOT)/usr/lib -landroid -lEGL $(GLES_LIB) $(LOGGER_LDLIBS) -ldl
LOCAL_C_INCLUDES := \
							$(LOCAL_PATH)/$(RARCH_DIR)/libretro-common/include/ \
							$(LOCAL_PATH)/$(RARCH_DIR)/deps


ifeq ($(HAVE_VULKAN),1)
INCFLAGS         += $(LOCAL_PATH)/$(RARCH_DIR)/gfx/include

LOCAL_C_INCLUDES += $(INCFLAGS)
LOCAL_CPPFLAGS   += -I$(LOCAL_PATH)/$(DEPS_DIR)/glslang \
						  -I$(LOCAL_PATH)/$(DEPS_DIR)/glslang/glslang/glslang/Public \
						  -I$(LOCAL_PATH)/$(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent \
						  -I$(LOCAL_PATH)/$(DEPS_DIR)/glslang/glslang/SPIRV \
						  -I$(LOCAL_PATH)/$(DEPS_DIR)/spir2cross \
						  -I$(LOCAL_PATH)/$(DEPS_DIR)/SPIRV-Cross

LOCAL_CFLAGS    += -Wno-sign-compare -Wno-unused-variable -Wno-parentheses
LOCAL_SRC_FILES += $(DEPS_DIR)/glslang/glslang.cpp \
                 $(DEPS_DIR)/glslang/glslang/SPIRV/SpvBuilder.cpp \
                 $(DEPS_DIR)/glslang/glslang/SPIRV/Logger.cpp \
                 $(DEPS_DIR)/glslang/glslang/SPIRV/SPVRemapper.cpp \
                 $(DEPS_DIR)/glslang/glslang/SPIRV/InReadableOrder.cpp \
                 $(DEPS_DIR)/glslang/glslang/SPIRV/doc.cpp \
                 $(DEPS_DIR)/glslang/glslang/SPIRV/GlslangToSpv.cpp \
                 $(DEPS_DIR)/glslang/glslang/SPIRV/disassemble.cpp \
                 $(DEPS_DIR)/glslang/glslang/OGLCompilersDLL/InitializeDll.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/GenericCodeGen/Link.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/GenericCodeGen/CodeGen.cpp \
                 $(DEPS_DIR)/glslang/glslang/hlsl/hlslAttributes.cpp \
                 $(DEPS_DIR)/glslang/glslang/hlsl/hlslGrammar.cpp \
                 $(DEPS_DIR)/glslang/glslang/hlsl/hlslOpMap.cpp \
                 $(DEPS_DIR)/glslang/glslang/hlsl/hlslTokenStream.cpp \
                 $(DEPS_DIR)/glslang/glslang/hlsl/hlslScanContext.cpp \
                 $(DEPS_DIR)/glslang/glslang/hlsl/hlslParseHelper.cpp \
                 $(DEPS_DIR)/glslang/glslang/hlsl/hlslParseables.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/Intermediate.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/propagateNoContraction.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/glslang_tab.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/Versions.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/RemoveTree.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/limits.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/intermOut.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/Initialize.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/SymbolTable.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/parseConst.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/ParseContextBase.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/ParseHelper.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/ShaderLang.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/IntermTraverse.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/iomapper.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/InfoSink.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/Constant.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/Scan.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/reflection.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/linkValidate.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/PoolAlloc.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/preprocessor/PpAtom.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/preprocessor/PpContext.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/preprocessor/PpMemory.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/preprocessor/PpTokens.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/preprocessor/PpScanner.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/preprocessor/PpSymbols.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/MachineIndependent/preprocessor/Pp.cpp \
                 $(DEPS_DIR)/glslang/glslang/glslang/OSDependent/Unix/ossource.cpp
endif

LOCAL_LDLIBS += -lOpenSLES -lz

ifneq ($(SANITIZER),)
   LOCAL_CFLAGS   += -g -fsanitize=$(SANITIZER) -fno-omit-frame-pointer
   LOCAL_CPPFLAGS += -g -fsanitize=$(SANITIZER) -fno-omit-frame-pointer
   LOCAL_LDFLAGS  += -fsanitize=$(SANITIZER)
endif

include $(BUILD_SHARED_LIBRARY)
