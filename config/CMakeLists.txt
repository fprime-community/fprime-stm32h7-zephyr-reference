register_fprime_config(
        fprime-nucleo_h723zg-reference-config
    CONFIGURATION_OVERRIDES
        "${CMAKE_CURRENT_LIST_DIR}/FpConfig.h"
        "${CMAKE_CURRENT_LIST_DIR}/ZephyrConfig.hpp"
    INTERFACE
)