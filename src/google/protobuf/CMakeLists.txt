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
   descriptor.h
   descriptor.pb.cc
   descriptor.pb.h
   descriptor_database.cc
   descriptor_database.h
   dynamic_message.cc
   dynamic_message.h
   extension_set.cc
   extension_set.h
   extension_set_heavy.cc
   generated_message_reflection.cc
   generated_message_reflection.h
   generated_message_util.cc
   generated_message_util.h
   message.cc
   message.h
   message_lite.cc
   message_lite.h
   reflection_ops.cc
   reflection_ops.h
   repeated_field.cc
   repeated_field.h
   service.cc
   service.h
   text_format.cc
   text_format.h
   unknown_field_set.cc
   unknown_field_set.h
   wire_format.cc
   wire_format.h
   wire_format_lite.cc
   wire_format_lite.h
   wire_format_lite_inl.h
   compiler/importer.cc
   compiler/importer.h
   compiler/parser.cc
   compiler/parser.h
   compiler/code_generator.h
   compiler/command_line_interface.h
   compiler/mock_code_generator.h
   compiler/package_info.h
   compiler/plugin.h
   compiler/plugin.pb.h
   compiler/subprocess.h
   compiler/zip_writer.h
   io/coded_stream.cc
   io/coded_stream.h
   io/coded_stream_inl.h
   io/gzip_stream.cc
   io/gzip_stream.h
   io/printer.cc
   io/printer.h
   io/tokenizer.cc
   io/tokenizer.h
   io/zero_copy_stream.cc
   io/zero_copy_stream.h
   io/zero_copy_stream_impl.cc
   io/zero_copy_stream_impl.h
   io/zero_copy_stream_impl_lite.cc
   io/zero_copy_stream_impl_lite.h
   stubs/common.cc
   stubs/common.h
   stubs/once.cc
   stubs/once.h
   stubs/structurally_valid.cc
   stubs/strutil.cc
   stubs/strutil.h
   stubs/substitute.cc
   stubs/substitute.h
   stubs/hash.h
   stubs/map-util.h
   stubs/stl_util-inl.h
)

Generateproject(${PROTOBUF_SOURCES})
add_library(protobuf STATIC
   ${PROTOBUF_SOURCES}
)


set(PROTOBUF_LITE_SOURCES
   ../../../config/config.h

   extension_set.cc
   extension_set.h
   generated_message_util.cc
   generated_message_util.h
   message_lite.cc
   message_lite.h
   repeated_field.cc
   repeated_field.h
   wire_format_lite.cc
   wire_format_lite.h

   io/zero_copy_stream.cc
   io/zero_copy_stream.h
   io/zero_copy_stream_impl.cc
   io/zero_copy_stream_impl.h
   io/zero_copy_stream_impl_lite.cc
   io/zero_copy_stream_impl_lite.h

   stubs/common.cc
   stubs/common.h
   stubs/once.cc
   stubs/once.h
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
