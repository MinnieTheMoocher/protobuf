
cmake_minimum_required(VERSION 2.8)


# DCMAKE_BUILD_TYPE:STRING=<build type>
IF(NOT CMAKE_BUILD_TYPE)
   # by default build debug
   SET(CMAKE_BUILD_TYPE "Debug")
ENDIF(NOT CMAKE_BUILD_TYPE)

option(WITH_QT5 "Enable to use Qt5, set QT_DIR to your installation directory.")

# Add local package detection rules
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")


#uncomment to generate a json file with all build files
#this is used to create/update the understand project
#set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Call cmake with this parameter
# cmake -DTC_PREFIX=<path-to-toolchain> -DCMAKE_TOOLCHAIN_FILE=Platform/Toolchain-<system>-<cpu>.cmake ../<path-to-source>

SET(CMAKE_C_FLAGS_DEBUG "-O0 -g")
SET(CMAKE_C_FLAGS_RELEASE "-Os")
SET(CMAKE_CXX_FLAGS_DEBUG "-O0 -g")
SET(CMAKE_CXX_FLAGS_RELEASE "-Os")

# DO NOT REMOVE - this will cause the NaviDemo to sigsegv (signal 11)
add_definitions("-fsigned-char")
add_definitions("-D_GNU_SOURCE")
add_definitions("-Wno-write-strings")
add_definitions("-Wno-unused-function")
add_definitions("-Wformat")
add_definitions("-Wformat=2")
add_definitions("-Wno-error=format-nonliteral")
add_definitions("-Wshadow")
add_definitions("-fno-omit-frame-pointer")

#add_definitions("-Wall -Wextra")
#add_definitions("-Werror") # gcc 4.4.1 stops compiling here
#add_definitions("-Winline")
#add_definitions("-Wno-comment")
#add_definitions("-Wno-unused-but-set-variable")
#add_definitions("-Wunused-function")
#add_definitions("-Wno-unused-variable")
#add_definitions("-Wno-write-strings")
#add_definitions("-Wunreachable-code") # gcc 4.4.1 stops compiling here
#add_definitions("-Wold-style-cast")B

# omit temporary files
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pipe")

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  # enable C++11 mode
  # Works for gcc 4.4 and 4.7
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
  # check-new is only for c++
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fcheck-new")
  # Guard all stack frames
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fstack-protector-all")
  # prevent narrowing
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  # check for memory errors
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address")
  # bound checks
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fbounds-checking")
  # realign stack
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mstackrealign")
endif()




add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/protobuf/src/google/protobuf)


