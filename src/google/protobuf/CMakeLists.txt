cmake_minimum_required(VERSION 2.8)
project(protobuf)

include_directories(BEFORE
   ${CMAKE_CURRENT_SOURCE_DIR}
   ${CMAKE_CURRENT_SOURCE_DIR}/../../../src
   ${CMAKE_CURRENT_SOURCE_DIR}/../../../config
)

set(PROTOBUF_SOURCES
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

Generateproject(${PROTOBUF_SOURCES})
add_library(protobuf STATIC
   ${PROTOBUF_SOURCES}
)

set(PROTOBUF_LITE_SOURCES
   ../../../config/config.h
   extension_set.cc
   generated_message_util.cc
   message_lite.cc
   repeated_field.cc
   wire_format_lite.cc

   io/coded_stream.cc
   io/zero_copy_stream.cc
   io/zero_copy_stream_impl_lite.cc

   stubs/common.cc
   stubs/once.cc
)

Generateproject(${PROTOBUF_LITE_SOURCES})
add_library(protobuf_lite STATIC
   ${PROTOBUF_LITE_SOURCES}
)


