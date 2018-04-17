set(
    submodules
    RapidJSON
    websocketpp
    folly
)

foreach(submodule ${submodules})
  hunter_config(${submodule} GIT_SUBMODULE third_party/${submodule})
endforeach()

hunter_config(glog VERSION ${HUNTER_glog_VERSION} CMAKE_ARGS BUILD_TESTING=OFF)
