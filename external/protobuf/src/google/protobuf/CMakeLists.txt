cmake_minimum_required(VERSION 2.8)
project(libprotobuf)

remove_definitions(-Wshadow)

include_directories(
   ${CMAKE_CURRENT_SOURCE_DIR}
   ${CMAKE_SOURCE_DIR}/external/protobuf/src
   ${CMAKE_SOURCE_DIR}/external/protobuf/config
   )


set(SOURCES
   ../../../config/config.h
   descriptor.cc
   descriptor.pb.cc
   descriptor_database.cc
   dynamic_message.cc
   extension_set.cc
   extension_set_heavy.cc
   generated_message_reflection.cc
   generated_message_util.cc
   message.cc
   message_lite.cc
   reflection_ops.cc
   repeated_field.cc
   service.cc
   text_format.cc
   unknown_field_set.cc
   wire_format.cc
   wire_format_lite.cc
   compiler/importer.cc
   compiler/parser.cc
   io/coded_stream.cc
   io/gzip_stream.cc
   io/printer.cc
   io/tokenizer.cc
   io/zero_copy_stream.cc
   io/zero_copy_stream_impl.cc
   io/zero_copy_stream_impl_lite.cc
   stubs/common.cc
   stubs/once.cc
   stubs/structurally_valid.cc
   stubs/strutil.cc
   stubs/substitute.cc
   )


if (CMAKE_CROSSCOMPILING)
   if (CMAKE_SYSTEM_PROCESSOR STREQUAL "arm")
   else(CMAKE_SYSTEM_PROCESSOR STREQUAL "arm")
      message(FATAL_ERROR "Processor ${CMAKE_SYSTEM_PROCESSOR) not supported.")
   endif(CMAKE_SYSTEM_PROCESSOR STREQUAL "arm")

else (CMAKE_CROSSCOMPILING)
   if (UNIX)
      if (NOT APPLE)
         #set(SOURCES
            #${SOURCES}
            #)
      endif (NOT APPLE)
   else (UNIX)
      if (WIN32)
         #set(SOURCES
            #${SOURCES}
            #)
      endif (WIN32)
   endif (UNIX)
endif(CMAKE_CROSSCOMPILING)

add_library(libprotobuf STATIC
   ${SOURCES}
)
