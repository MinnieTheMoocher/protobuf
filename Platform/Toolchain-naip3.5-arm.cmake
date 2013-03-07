# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

SET(CMAKE_SYSTEM_PROCESSOR "arm")

if(NOT DEFINED TC_PREFIX)
  message(FATAL "Toolchain Prefix (TC_PREFIX) is not set. Call cmake with 
                 -DTC_PREFIX=/path/to/toolchain.")
endif()

include(CMakeForceCompiler)
CMAKE_FORCE_C_COMPILER(arm-naip-linux-gnueabi-gcc GNU)
CMAKE_FORCE_CXX_COMPILER(arm-naip-linux-gnueabi-g++ GNU)

# specify the cross compiler
SET(CMAKE_C_COMPILER
${TC_PREFIX}/naip/3.5/sysroots/i686-linux/usr/bin/armv7a-vfp-neon-naip-linux-gnueabi/arm-naip-linux-gnueabi-gcc
)
SET(CMAKE_CXX_COMPILER
${TC_PREFIX}/naip/3.5/sysroots/i686-linux/usr/bin/armv7a-vfp-neon-naip-linux-gnueabi/arm-naip-linux-gnueabi-g++
)

add_definitions(--sysroot=${TC_PREFIX}/naip/3.5/sysroots/imx6qsabrelite)
set(CMAKE_EXE_LINKER_FLAGS --sysroot=${TC_PREFIX}/naip/3.5/sysroots/imx6qsabrelite)

# where is the target environment
SET(CMAKE_FIND_ROOT_PATH
${TC_PREFIX}/naip/3.5/sysroots/imx6qsabrelite
)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
