set(
    submodules
    RapidJSON
    websocketpp
    folly
    duktape
    Protobuf
)

foreach(submodule ${submodules})
  hunter_config(${submodule} GIT_SUBMODULE third_party/${submodule})
endforeach()
