# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.20.0)

find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(wifi)

add_subdirectory(lib)
add_subdirectory(drivers)

set(CMAKE_VERBOSE_MAKEFILE on)

FILE(GLOB app_sources src/*.cpp)

target_sources(app
    PRIVATE
        ${app_sources}
    )

target_link_libraries(app PUBLIC protos)
