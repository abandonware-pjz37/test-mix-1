hunter_config(RapidJSON VERSION 0.11-p2)
hunter_config(Protobuf VERSION 2.4.1-p0)

hunter_config(
    ICU
    VERSION ${HUNTER_ICU_VERSION}
    CMAKE_ARGS U_USING_ICU_NAMESPACE=ON
)
