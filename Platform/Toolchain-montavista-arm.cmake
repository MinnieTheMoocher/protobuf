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
CMAKE_FORCE_C_COMPILER(arm-montavista-linux-gnueabi-gcc GNU)
CMAKE_FORCE_CXX_COMPILER(arm-montavista-linux-gnueabi-g++ GNU)

# specify the cross compiler
SET(CMAKE_C_COMPILER
${TC_PREFIX}/MV_Tools/tools/arm-gnueabi/bin/arm-montavista-linux-gnueabi-gcc
)
SET(CMAKE_CXX_COMPILER
${TC_PREFIX}/MV_Tools/tools/arm-gnueabi/bin/arm-montavista-linux-gnueabi-c++
)

# where is the target environment
SET(CMAKE_FIND_ROOT_PATH
${TC_PREFIX}/montavista/freescale-smartdevice-adk/armv7a-mv-linux
)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
