cmake_minimum_required(VERSION 2.8)

if(CMAKE_COMPILER_IS_GNUCXX)

	set(CMAKE_C_FLAGS_DEBUG     "-O0 -g")
	set(CMAKE_CXX_FLAGS_DEBUG   "-O0 -g")

	set(CMAKE_C_FLAGS_RELEASE   "-Os")
	set(CMAKE_CXX_FLAGS_RELEASE "-Os")

	add_definitions("-fsigned-char")
	add_definitions("-D_GNU_SOURCE")
	add_definitions("-Wno-write-strings")
	add_definitions("-Wno-unused-function")
	add_definitions("-Wformat")
	add_definitions("-Wformat=2")
	add_definitions("-Wno-error=format-nonliteral")
	add_definitions("-fno-omit-frame-pointer")

    remove_definitions("-Wshadow")

	#add_definitions("-Wall -Wextra")
	#add_definitions("-Werror")

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
endif()

if(MSVC)
   add_definitions("/wd4018") # warning C4018: signed/unsigned mismatch
   add_definitions("/wd4244") # warning C4244: conversion from 'xyz' to 'xyz', possible loss of data
   add_definitions("/wd4355") # warning C4355: 'this' : used in base member initializer list
   add_definitions("/wd4800") # warning C4800: forcing value to bool 'true' or 'false' (performance warning)
endif()

set(PROTOBUF_INCLUDE_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/config
    PARENT_SCOPE
)

set(PROTOBUF_LIBRARIES protobuf PARENT_SCOPE)

set(PROTOBUF_PROTOC_EXECUTABLE ${CMAKE_CURRENT_SOURCE_DIR}/bin/protoc PARENT_SCOPE)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src/google/protobuf)
