# we need to be able to include generated header files
add_library(protos)
target_include_directories(protos
    PUBLIC
    .
    ${CMAKE_CURRENT_BINARY_DIR}
    )
set(PROTO_SOURCES ${PROTO_SRCS})

# Note that here, we're adding CMAKE_SOURCE_DIR to the include path for nanopb.
# This is needed because the below call to nanopb_generate_cpp() is using
# 'RELPATH .'
set(NANOPB_OPTIONS "-I${CMAKE_CURRENT_SOURCE_DIR}")
set(NANOPB_OPTIONS "-I${CMAKE_CURRENT_BINARY_DIR}")
nanopb_generate_cpp(PROTO_SRCS PROTO_HDRS
    RELPATH .
    messages.proto
    )

include_directories(${NANOPB_INCLUDE_DIRS})

target_sources(protos
    PRIVATE ${PROTO_HDRS}
    PRIVATE ${PROTO_SRCS}
    )

# add_library(protocol)
# target_include_directories(protocol
#   PUBLIC
#   .
#   ${CMAKE_CURRENT_BINARY_DIR}
#   ${Protobuf_INCLUDE_DIRS}
# )
# find_package(Protobuf REQUIRED)
# set(PROTO_SOURCES msg.proto)
# protobuf_generate_cpp(LIB_SOURCES LIB_HEADERS ${PROTO_SOURCES} )
# target_link_libraries(protocol ${Protobuf_LIBRARIES})
# target_sources(protocol
#   PUBLIC
#   ${LIB_HEADERS}
#   PRIVATE
#   ${LIB_SOURCES}
# )
