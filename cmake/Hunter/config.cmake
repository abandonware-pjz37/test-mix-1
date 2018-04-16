set(
    submodules
    RapidJSON
    websocketpp
)

foreach(submodule ${submodules})
  hunter_config(${submodule} GIT_SUBMODULE third_party/${submodule})
endforeach()
