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


set(PROTOC_SOURCES
   compiler/cpp/cpp_enum.cc
   compiler/cpp/cpp_enum.h
   compiler/cpp/cpp_enum_field.cc
   compiler/cpp/cpp_enum_field.h
   compiler/cpp/cpp_extension.cc
   compiler/cpp/cpp_extension.h
   compiler/cpp/cpp_field.cc
   compiler/cpp/cpp_field.h
   compiler/cpp/cpp_file.cc
   compiler/cpp/cpp_file.h
   compiler/cpp/cpp_generator.cc
   compiler/cpp/cpp_generator.h
   compiler/cpp/cpp_helpers.cc
   compiler/cpp/cpp_helpers.h
   compiler/cpp/cpp_message.cc
   compiler/cpp/cpp_message.h
   compiler/cpp/cpp_message_field.cc
   compiler/cpp/cpp_message_field.h
   compiler/cpp/cpp_primitive_field.cc
   compiler/cpp/cpp_primitive_field.h
   compiler/cpp/cpp_service.cc
   compiler/cpp/cpp_service.h
   compiler/cpp/cpp_string_field.cc
   compiler/cpp/cpp_string_field.h

   compiler/java/java_enum.cc
   compiler/java/java_enum.h
   compiler/java/java_enum_field.cc
   compiler/java/java_enum_field.h
   compiler/java/java_extension.cc
   compiler/java/java_extension.h
   compiler/java/java_field.cc
   compiler/java/java_field.h
   compiler/java/java_file.cc
   compiler/java/java_file.h
   compiler/java/java_generator.cc
   compiler/java/java_generator.h
   compiler/java/java_helpers.cc
   compiler/java/java_helpers.h
   compiler/java/java_message.cc
   compiler/java/java_message.h
   compiler/java/java_message_field.cc
   compiler/java/java_message_field.h
   compiler/java/java_primitive_field.cc
   compiler/java/java_primitive_field.h
   compiler/java/java_service.cc
   compiler/java/java_service.h
   compiler/java/java_string_field.cc
   compiler/java/java_string_field.h

   compiler/python/python_generator.cc
   compiler/python/python_generator.h

   compiler/code_generator.cc
   compiler/code_generator.h
   compiler/command_line_interface.cc
   compiler/command_line_interface.h
   compiler/importer.cc
   compiler/importer.h
   compiler/package_info.h
   compiler/parser.cc
   compiler/parser.h
   compiler/plugin.cc
   compiler/plugin.h
   compiler/plugin.pb.cc
   compiler/plugin.pb.h
   compiler/subprocess.cc
   compiler/subprocess.h
   compiler/zip_writer.cc
   compiler/zip_writer.h

   compiler/main.cc
)

#Generateproject(${PROTOC_SOURCES})
#add_executable(protoc ${PROTOC_SOURCES})
#target_link_libraries(protoc protobuf)
