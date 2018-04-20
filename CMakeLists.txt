cmake_minimum_required(VERSION 3.3)

include("cmake/module/test_mix_1_upload_config.cmake")

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.20.49.tar.gz"
    SHA1 "2e8d69f3d426a375978cb5270a1f4950ef07886e"
    LOCAL
)

project(test-mix-1)

set(skip_folly FALSE)

if(MSVC)
  string(COMPARE EQUAL "${MSVC_VERSION}" 1913 is_visual_studio_2017)
  string(COMPARE EQUAL "${MSVC_VERSION}" 1900 is_visual_studio_2015)
  string(COMPARE EQUAL "${MSVC_VERSION}" 1800 is_visual_studio_2013)

  if(is_visual_studio_2017)
    set(skip_folly FALSE)
  elseif(is_visual_studio_2015)
    set(skip_folly TRUE)
  elseif(is_visual_studio_2013)
    set(skip_folly TRUE)
  else()
    message(FATAL_ERROR "Unexpected Visual Studio version: '${MSVC_VERSION}'")
  endif()
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

hunter_add_package(duktape)
find_package(duktape CONFIG REQUIRED)
target_link_libraries(boo PUBLIC duktape::duktape)

hunter_add_package(Protobuf)
find_package(Protobuf CONFIG REQUIRED)
target_link_libraries(boo PUBLIC protobuf::libprotobuf)
