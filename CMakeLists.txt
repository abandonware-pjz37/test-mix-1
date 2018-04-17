cmake_minimum_required(VERSION 3.3)

include("cmake/module/test_mix_1_upload_config.cmake")

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.20.44.tar.gz"
    SHA1 "5a51c5fa3e2be7d1241d2b6405e197b9fe72333c"
    LOCAL
)

project(test-mix-1)

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

hunter_add_package(folly)
find_package(folly CONFIG REQUIRED)
target_link_libraries(boo PUBLIC Folly::folly)

hunter_add_package(duktape)
find_package(duktape CONFIG REQUIRED)
target_link_libraries(boo PUBLIC duktape::duktape)

hunter_add_package(Protobuf)
find_package(Protobuf CONFIG REQUIRED)
target_link_libraries(boo PUBLIC protobuf::libprotobuf)
