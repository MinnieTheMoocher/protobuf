cmake_minimum_required(VERSION 2.8.5)

DefaultCompileFlags(EXTERNAL)

set(PROTOBUF_INCLUDE_DIRS
   ${CMAKE_CURRENT_SOURCE_DIR}/src
   ${CMAKE_CURRENT_SOURCE_DIR}/config
   PARENT_SCOPE
)

set(PROTOBUF_LIBRARIES protobuf PARENT_SCOPE)
set(PROTOBUF_LITE_LIBRARIES protobuf_lite PARENT_SCOPE) # [New since CMake 2.8.5]. See CMake modules help 'FindProtobuf'

if(APPLE)
   set(PROTOBUF_PROTOC_EXECUTABLE ${CMAKE_CURRENT_SOURCE_DIR}/bin/apple/protoc       PARENT_SCOPE)
elseif(CMAKE_HOST_WIN32)
   set(PROTOBUF_PROTOC_EXECUTABLE ${CMAKE_CURRENT_SOURCE_DIR}/bin/win32/protoc.exe   PARENT_SCOPE)
elseif(CMAKE_HOST_UNIX) # assume we're on a Linux system
   # first, try 32bit executable:
   execute_process(COMMAND          ${CMAKE_CURRENT_SOURCE_DIR}/bin/linux32/protoc
                   RESULT_VARIABLE  PROTOC_32
                   OUTPUT_QUIET ERROR_QUIET)
   if("${PROTOC_32}" STREQUAL "1")
      set(PROTOBUF_PROTOC_EXECUTABLE ${CMAKE_CURRENT_SOURCE_DIR}/bin/linux32/protoc  PARENT_SCOPE)
   else()
     # now try 64bit executable:
     execute_process(COMMAND          ${CMAKE_CURRENT_SOURCE_DIR}/bin/linux64/protoc
                     RESULT_VARIABLE  PROTOC_64
                     OUTPUT_QUIET ERROR_QUIET)
     if("${PROTOC_64}" STREQUAL "1")
       set(PROTOBUF_PROTOC_EXECUTABLE ${CMAKE_CURRENT_SOURCE_DIR}/bin/linux64/protoc PARENT_SCOPE)
     else()
       message(WARNING "No working protoc found!")
     endif()
   endif()
else()
   message(WARNING "Unknown operating system, no working protoc found!")
endif()


add_subdirectory(src/google/protobuf)
