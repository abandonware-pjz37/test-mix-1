cmake_minimum_required(VERSION 3.3)

include("cmake/module/test_mix_1_upload_config.cmake")

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/560b85efa16387a95d642a691a27c8e140fd3b20.zip"
    SHA1 "dc2c79cf91f9ac7b4ca2ae4a3f91d98cb32f6ab2"
    LOCAL
)

project(test-mix-1)

set(skip_folly FALSE)
set(skip_webkit FALSE)
set(skip_protobuf FALSE)

if(MSVC)
  string(COMPARE EQUAL "${MSVC_VERSION}" 1913 is_visual_studio_2017)
  string(COMPARE EQUAL "${MSVC_VERSION}" 1900 is_visual_studio_2015)
  string(COMPARE EQUAL "${MSVC_VERSION}" 1800 is_visual_studio_2013)

  if(is_visual_studio_2017)
    set(skip_folly FALSE)
    set(skip_webkit FALSE)
  elseif(is_visual_studio_2015)
    set(skip_folly TRUE)
    set(skip_webkit TRUE)
  elseif(is_visual_studio_2013)
    set(skip_folly TRUE)
    set(skip_webkit TRUE)
  else()
    message(FATAL_ERROR "Unexpected Visual Studio version: '${MSVC_VERSION}'")
  endif()
endif()

if(IOS)
  set(skip_webkit TRUE)
endif()

string(COMPARE EQUAL "${CMAKE_SYSTEM_NAME}" "WindowsStore" is_windows_store)
if(is_windows_store)
  # FIXME
  set(skip_webkit TRUE)
  set(skip_protobuf TRUE)
endif()

hunter_add_package(ICU)
find_package(ICU CONFIG REQUIRED)

add_executable(boo boo.cpp)
target_link_libraries(boo PUBLIC ICU::uc)

hunter_add_package(RapidJSON)
find_package(RapidJSON CONFIG REQUIRED)

target_link_libraries(boo PUBLIC RapidJSON::rapidjson)

hunter_add_package(websocketpp)
find_package(websocketpp CONFIG REQUIRED)
target_link_libraries(boo PUBLIC websocketpp::websocketpp)

if(skip_folly)
  message("Skip 'folly' package")
  target_compile_definitions(boo PUBLIC SKIP_FOLLY)
else()
  hunter_add_package(folly)
  find_package(folly CONFIG REQUIRED)
  target_link_libraries(boo PUBLIC Folly::folly)
endif()

if(skip_webkit)
  message("Skip 'WebKit' package")
  target_compile_definitions(boo PUBLIC SKIP_WEBKIT)
else()
  hunter_add_package(WebKit)
  find_package(WebKit CONFIG REQUIRED)
  target_link_libraries(
      boo
      PUBLIC
      WebKit::JavaScriptCore
      WebKit::WTF
  )
endif()

hunter_add_package(duktape)
find_package(duktape CONFIG REQUIRED)
target_link_libraries(boo PUBLIC duktape::duktape)

if(skip_protobuf)
  message("Skip 'Protobuf' package")
  target_compile_definitions(boo PUBLIC SKIP_PROTOBUF)
else()
  hunter_add_package(Protobuf)
  find_package(Protobuf CONFIG REQUIRED)
  target_link_libraries(boo PUBLIC protobuf::libprotobuf)
endif()
