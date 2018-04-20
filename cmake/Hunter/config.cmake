set(
    submodules
    RapidJSON
    websocketpp
    folly
    duktape
    Protobuf
    glog
)

foreach(submodule ${submodules})
  hunter_config(${submodule} GIT_SUBMODULE third_party/${submodule})
endforeach()

set(enable_jit ON)
if(ANDROID)
  string(COMPARE EQUAL "${CMAKE_ANDROID_ARCH_ABI}" x86 _abi_x86)
  string(COMPARE EQUAL "${CMAKE_ANDROID_ARCH_ABI}" armeabi-v7a _abi_arm)
  string(COMPARE EQUAL "${CMAKE_ANDROID_ARCH_ABI}" arm64-v8a _abi_arm64)

  if(_abi_x86)
    set(enable_jit OFF)
  elseif(_abi_arm)
    set(enable_jit OFF)
  elseif(_abi_arm64)
    set(enable_jit ON)
  else()
    message(FATAL_ERROR "Unexpected: ${CMAKE_ANDROID_ARCH_ABI}")
  endif()
endif()

hunter_config(
    WebKit
    GIT_SUBMODULE
    third_party/WebKit
    CMAKE_ARGS
    CMAKE_BUILD_TYPE=Release CMAKE_CONFIGURATION_TYPES=Release

    PORT=JSCOnly
    ENABLE_TOOLS=OFF
    ENABLE_API_TESTS=OFF
    ENABLE_WEBCORE=OFF
    ENABLE_WEBKIT=OFF
    ENABLE_JIT=${enable_jit}
)
