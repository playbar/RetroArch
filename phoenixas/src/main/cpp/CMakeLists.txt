cmake_minimum_required(VERSION 3.4.1)


set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} \
            -Wall -std=gnu99 -pthread -Wno-unused-function -fno-stack-protector -funroll-loops -Wno-invalid-source-encoding")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fexceptions -fpermissive -std=c++11 -fno-rtti -Wno-reorder -Wno-invalid-source-encoding")

ADD_DEFINITIONS(-DANDROID_ARM)
ADD_DEFINITIONS( -DHAVE_OPENGLES3)
ADD_DEFINITIONS(-DSINC_LOWER_QUALITY -DANDROID_ARM_V7)
ADD_DEFINITIONS(-DHAVE_ZLIB -DRARCH_MOBILE -DHAVE_GRIFFIN -DHAVE_STB_VORBIS -DHAVE_LANGEXTRA -DANDROID -DHAVE_DYNAMIC -DHAVE_OPENGL)
ADD_DEFINITIONS(-DHAVE_FBO -DHAVE_OVERLAY -DHAVE_OPENGLES -DGLSL_DEBUG -DHAVE_DYLIB -DHAVE_EGL -DHAVE_GLSL -DHAVE_MENU -DHAVE_RGUI)
ADD_DEFINITIONS(-DHAVE_RPNG -DHAVE_RJPEG -DHAVE_RBMP -DHAVE_RTGA -DINLINE=inline -DHAVE_THREADS -D__LIBRETRO__ -DHAVE_RSOUND -DHAVE_NETWORKGAMEPAD -DHAVE_NETWORKING)
ADD_DEFINITIONS(-DRARCH_INTERNAL -DHAVE_FILTERS_BUILTIN -DHAVE_MATERIALUI -DHAVE_XMB -DHAVE_SHADERPIPELINE -DHAVE_LIBRETRODB -DHAVE_STB_FONT)
ADD_DEFINITIONS( -DHAVE_IMAGEVIEWER -DHAVE_UPDATE_ASSETS -DHAVE_CC_RESAMPLER -DHAVE_MINIUPNPC -DHAVE_BUILTINMINIUPNPC -DMINIUPNPC_SET_SOCKET_TIMEOUT)
ADD_DEFINITIONS(-DMINIUPNPC_GET_SRC_ADDR -DWANT_IFADDRS -DHAVE_SHADERS -DHAVE_COMPRESSION -DJSON_STATIC )
ADD_DEFINITIONS(-DHAVE_VULKAN)
ADD_DEFINITIONS(-DHAVE_7ZIP -DHAVE_CHEEVOS -DHAVE_SL)


set(RARCH_DIR ../../../..)
set(LIBRETRO_COMM_DIR ${RARCH_DIR}/libretro-common)
set(DEPS_DIR ${RARCH_DIR}/deps)

SET(HAVE_ZLIB true)

##################################################
#retroarch-activity so
MESSAGE(STATUS "Project: retroarch-activity")

#make retroarch-activity

add_library(retroarch-activity SHARED
            ${LIBRETRO_COMM_DIR}/audio/conversion/s16_to_float_neon.S
            ${LIBRETRO_COMM_DIR}/audio/conversion/float_to_s16_neon.S
            ${LIBRETRO_COMM_DIR}/audio/resampler/drivers/sinc_resampler_neon.S
            ${RARCH_DIR}/audio/drivers_resampler/cc_resampler_neon.S
                ${RARCH_DIR}/griffin/griffin1.c
                ${RARCH_DIR}/libretro-common/net/net_http_parse.c
                ${RARCH_DIR}/deps/7zip/7zIn.c
                ${RARCH_DIR}/deps/7zip/7zAlloc.c
                ${RARCH_DIR}/deps/7zip/Bra86.c
                ${RARCH_DIR}/deps/7zip/7zFile.c
                ${RARCH_DIR}/deps/7zip/7zStream.c
                ${RARCH_DIR}/deps/7zip/7zBuf2.c
                ${RARCH_DIR}/deps/7zip/LzmaDec.c
                ${RARCH_DIR}/deps/7zip/7zCrcOpt.c
                ${RARCH_DIR}/deps/7zip/Bra.c
                ${RARCH_DIR}/deps/7zip/7zDec.c
                ${RARCH_DIR}/deps/7zip/Bcj2.c
                ${RARCH_DIR}/deps/7zip/7zCrc.c
                ${RARCH_DIR}/deps/7zip/Lzma2Dec.c
                ${RARCH_DIR}/deps/7zip/7zBuf.c
                ${RARCH_DIR}/libretro-common/audio/conversion/s16_to_float.c
                ${RARCH_DIR}/libretro-common/audio/conversion/float_to_s16.c
                ${RARCH_DIR}/libretro-common/audio/audio_mix.c
                ${RARCH_DIR}/libretro-db/bintree.c
                ${RARCH_DIR}/libretro-db/libretrodb.c
                ${RARCH_DIR}/libretro-db/rmsgpack.c
                ${RARCH_DIR}/libretro-db/rmsgpack_dom.c
                ${RARCH_DIR}/libretro-db/query.c
                ${RARCH_DIR}/database_info.c
                ${RARCH_DIR}/deps/miniupnpc/igd_desc_parse.c
                ${RARCH_DIR}/deps/miniupnpc/upnpreplyparse.c
                ${RARCH_DIR}/deps/miniupnpc/upnpcommands.c
                ${RARCH_DIR}/deps/miniupnpc/upnperrors.c
                ${RARCH_DIR}/deps/miniupnpc/connecthostport.c
                ${RARCH_DIR}/deps/miniupnpc/portlistingparse.c
                ${RARCH_DIR}/deps/miniupnpc/receivedata.c
                ${RARCH_DIR}/deps/miniupnpc/upnpdev.c
                ${RARCH_DIR}/deps/miniupnpc/minissdpc.c
                ${RARCH_DIR}/deps/miniupnpc/miniwget.c
                ${RARCH_DIR}/deps/miniupnpc/miniupnpc.c
                ${RARCH_DIR}/deps/miniupnpc/minixml.c
                ${RARCH_DIR}/deps/miniupnpc/minisoap.c
            ${RARCH_DIR}/griffin/griffin_cpp.cpp
            ${DEPS_DIR}/glslang/glslang.cpp
            ${DEPS_DIR}/glslang/glslang/SPIRV/SpvBuilder.cpp
            ${DEPS_DIR}/glslang/glslang/SPIRV/Logger.cpp
            ${DEPS_DIR}/glslang/glslang/SPIRV/SPVRemapper.cpp
            ${DEPS_DIR}/glslang/glslang/SPIRV/InReadableOrder.cpp
            ${DEPS_DIR}/glslang/glslang/SPIRV/doc.cpp
            ${DEPS_DIR}/glslang/glslang/SPIRV/GlslangToSpv.cpp
            ${DEPS_DIR}/glslang/glslang/SPIRV/disassemble.cpp
            ${DEPS_DIR}/glslang/glslang/OGLCompilersDLL/InitializeDll.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/GenericCodeGen/Link.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/GenericCodeGen/CodeGen.cpp
            ${DEPS_DIR}/glslang/glslang/hlsl/hlslAttributes.cpp
            ${DEPS_DIR}/glslang/glslang/hlsl/hlslGrammar.cpp
            ${DEPS_DIR}/glslang/glslang/hlsl/hlslOpMap.cpp
            ${DEPS_DIR}/glslang/glslang/hlsl/hlslTokenStream.cpp
            ${DEPS_DIR}/glslang/glslang/hlsl/hlslScanContext.cpp
            ${DEPS_DIR}/glslang/glslang/hlsl/hlslParseHelper.cpp
            ${DEPS_DIR}/glslang/glslang/hlsl/hlslParseables.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/Intermediate.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/propagateNoContraction.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/glslang_tab.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/Versions.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/RemoveTree.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/limits.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/intermOut.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/Initialize.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/SymbolTable.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/parseConst.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/ParseContextBase.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/ParseHelper.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/ShaderLang.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/IntermTraverse.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/iomapper.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/InfoSink.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/Constant.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/Scan.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/reflection.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/linkValidate.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/PoolAlloc.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/preprocessor/PpAtom.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/preprocessor/PpContext.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/preprocessor/PpMemory.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/preprocessor/PpTokens.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/preprocessor/PpScanner.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/preprocessor/PpSymbols.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/preprocessor/Pp.cpp
            ${DEPS_DIR}/glslang/glslang/glslang/OSDependent/Unix/ossource.cpp
            )

target_include_directories(retroarch-activity PRIVATE
                           ${CMAKE_SOURCE_DIR}/
                           ${RARCH_DIR}/libretro-common/include/
                           ${RARCH_DIR}/gfx/include/
                           ${RARCH_DIR}/deps/
                           ${DEPS_DIR}/glslang/
                           ${DEPS_DIR}/glslang/glslang/glslang/Public/
                           ${DEPS_DIR}/glslang/glslang/glslang/MachineIndependent/
                           ${DEPS_DIR}/glslang/glslang/SPIRV/
                           ${DEPS_DIR}/spir2cross/
                           ${DEPS_DIR}/SPIRV-Cross/
                           )

target_link_libraries(retroarch-activity
                      log
                      android
                      EGL
                      GLESv3
                      OpenSLES
                      z)


