cmake_minimum_required(VERSION 3.3)

include("cmake/module/test_mix_1_upload_config.cmake")

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.20.41.tar.gz"
    SHA1 "e8e77b69fc2ca66808091e781cc06bcb02724443"
)

project(test-mix-1)

hunter_add_package(ICU)
find_package(ICU CONFIG REQUIRED)

add_executable(boo boo.cpp)
target_link_libraries(boo PUBLIC ICU::uc)
