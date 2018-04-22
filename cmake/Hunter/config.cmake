set(
    submodules
    RapidJSON
    websocketpp
    folly
    duktape
    glog
)

foreach(submodule ${submodules})
  hunter_config(${submodule} GIT_SUBMODULE third_party/${submodule})
endforeach()

if(is_windows_store OR IOS OR ANDROID)
  set(protobuf_arg_protoc OFF)
else()
  set(protobuf_arg_protoc ON)
endif()

hunter_config(
    Protobuf
    GIT_SUBMODULE
    third_party/Protobuf
    CMAKE_ARGS
    protobuf_BUILD_PROTOC=${protobuf_arg_protoc}
)
