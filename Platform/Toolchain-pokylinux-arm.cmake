# Define the target system.
SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_VERSION 1)

# Define the system processor. Lowercase only!
SET(CMAKE_SYSTEM_PROCESSOR "arm")

# Specify the cross compilers
SET(CMAKE_C_COMPILER
/opt/poky/1.2.1/sysroots/i686-pokysdk-linux/usr/bin/armv7a-vfp-neon-poky-linux-gnueabi/arm-poky-linux-gnueabi-gcc
)

SET(CMAKE_CXX_COMPILER
/opt/poky/1.2.1/sysroots/i686-pokysdk-linux/usr/bin/armv7a-vfp-neon-poky-linux-gnueabi/arm-poky-linux-gnueabi-g++
)

# Path to the target environment
SET(CMAKE_FIND_ROOT_PATH
/opt/poky/1.2.1/sysroots/armv7a-vfp-neon-poky-linux-gnueabi
)

# Path to the target qmake
SET(QT_QMAKE_EXECUTABLE
/opt/poky/1.2.1/sysroots/armv7a-vfp-neon-poky-linux-gnueabi/usr/bin/qmake
)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
