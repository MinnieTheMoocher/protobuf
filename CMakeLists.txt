
cmake_minimum_required(VERSION 2.8)
PROJECT(protobuf)


# DCMAKE_BUILD_TYPE:STRING=<build type>
IF(NOT CMAKE_BUILD_TYPE)
   # by default build debug
   SET(CMAKE_BUILD_TYPE "Debug")
ENDIF(NOT CMAKE_BUILD_TYPE)

option(WITH_QT5 "Enable to use Qt5, set QT_DIR to your installation directory.")

# Add local package detection rules
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

if(WITH_QT5)
  find_package(Qt5Core REQUIRED)
  find_package(Qt5DBus REQUIRED)
  find_package(Qt5Gui REQUIRED)
  find_package(Qt5Widgets REQUIRED)
  find_package(Qt5Test REQUIRED)
  find_package(Qt5Network REQUIRED)

  add_definitions(${Qt5DBus_DEFINITIONS})
  add_definitions(${Qt5Gui_DEFINITIONS})
  add_definitions(${Qt5Core_DEFINITIONS})
  add_definitions(${Qt5Widgets_DEFINITIONS})
  add_definitions(${Qt5Test_DEFINITIONS})
  add_definitions(${Qt5Network_DEFINITIONS})

  include_directories(${Qt5DBus_INCLUDE_DIRS})
  include_directories(${Qt5Gui_INCLUDE_DIRS})
  include_directories(${Qt5Core_INCLUDE_DIRS})
  include_directories(${Qt5Widgets_INCLUDE_DIRS})
  include_directories(${Qt5Test_INCLUDE_DIRS})
  include_directories(${Qt5Network_INCLUDE_DIRS})

  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${Qt5Widgets_EXECUTABLE_COMPILE_FLAGS} -fPIC ")
else()
  find_package (Qt4 COMPONENTS QtCore QtGui QtDBus QtNetwork REQUIRED)

  include (${QT_USE_FILE})
  include_directories(${QT_DBUS_INCLUDE_DIR})

  link_directories(${QT_LIBRARY_DIR})
endif()

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


find_package(Git REQUIRED)

file(WRITE ${CMAKE_BINARY_DIR}/git_version.cmake
"# get current revision
execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --short --verify --sq HEAD
                WORKING_DIRECTORY \"${CMAKE_SOURCE_DIR}\"
                OUTPUT_VARIABLE GIT_REVISION
                OUTPUT_STRIP_TRAILING_WHITESPACE
                ERROR_QUIET)
# sanitize output
string(REPLACE \"'\" \"\" GIT_REVISION \"\${GIT_REVISION}\")
message(STATUS \"Current revision: \${GIT_REVISION}\")

# get tag for current revision
execute_process(COMMAND ${GIT_EXECUTABLE} describe --dirty
                WORKING_DIRECTORY \"${CMAKE_SOURCE_DIR}\"
                OUTPUT_VARIABLE GIT_TAG
                OUTPUT_STRIP_TRAILING_WHITESPACE
                ERROR_QUIET)
# sanitize output
string(REPLACE \"'\" \"\" GIT_TAG \"\${GIT_TAG}\")
message(STATUS \"Tag information: \${GIT_TAG}\")

if(NOT GIT_REVISION)
  message(WARNING \"Failed getting revision.\")
  set(GIT_REVISION \"0000000\")
endif()

# configure file (generate configure.hpp)
message(STATUS \"Updating configuration.\")
configure_file(${CMAKE_SOURCE_DIR}/configure.hpp.in
               ${CMAKE_BINARY_DIR}/configure.hpp
               @ONLY NEWLINE_STYLE UNIX)
")

# define command
add_custom_command(OUTPUT UpdateGitRevision
                   DEPENDS ${CMAKE_SOURCE_DIR}/configure.hpp.in)

# define target, that calls indirectly configure_file
add_custom_target(UpdateGitRevision
                  COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/git_version.cmake
                  SOURCES ${CMAKE_SOURCE_DIR}/configure.hpp.in)

# set property for generated file
set_source_files_properties(${CMAKE_BINARY_DIR}/configure.hpp
                            PROPERTIES GENERATED TRUE
                            HEADER_FILE_ONLY TRUE)


message(STATUS "Using bundled protobuf.")
set(PROTOBUF_INCLUDE_DIRS
    ${CMAKE_SOURCE_DIR}/external/protobuf/src
    ${CMAKE_SOURCE_DIR}/external/protobuf/config
    )
set(PROTOBUF_LIBRARIES libprotobuf)
set(PROTOBUF_PROTOC_EXECUTABLE ${CMAKE_SOURCE_DIR}/external/protobuf/bin/protoc)

message(STATUS "PROTOBUF: ${PROTOBUF_VERSION_STRING}")
message(STATUS " INC: ${PROTOBUF_INCLUDE_DIRS}")
message(STATUS " LIB: ${PROTOBUF_LIBRARIES}")
message(STATUS " EXE: ${PROTOBUF_PROTOC_EXECUTABLE}")

include_directories(BEFORE
   ${CMAKE_SOURCE_DIR}
   ${PROTOBUF_INCLUDE_DIRS}
   )

# build switches
add_definitions("-DUSE_QT=1")

add_subdirectory(${CMAKE_SOURCE_DIR}/protobuf/src/google/protobuf)

