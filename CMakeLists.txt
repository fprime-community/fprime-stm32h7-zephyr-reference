####
# This sets up the build system for the 'fprime-nucleo_h723zg-zephyr-reference' project, including
# components and deployments from project.cmake. In addition, it imports the core F Prime components.
####

cmake_minimum_required(VERSION 3.24.2)

list(APPEND BOARD_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/lib/fprime-stm32h7-zephyr")
find_package(Zephyr HINTS "${CMAKE_CURRENT_LIST_DIR}/lib/zephyr-workspace")
project(fprime-nucleo_h723zg-zephyr-reference C CXX)

# Put in an option to force the device back into programable state for automated testing
option(FPRIME_CI_FAILSAFE_ENABLED "Cycle count before a forced reset to programable state" OFF)
if (FPRIME_CI_FAILSAFE_ENABLED)
    set(FPRIME_CI_FAILSAFE_CYCLE_COUNT 6000 CACHE STRING "Cycles before a forced reset")
    add_compile_definitions(FPRIME_CI_FAILSAFE_CYCLE_COUNT=${FPRIME_CI_FAILSAFE_CYCLE_COUNT})
endif()

###
# F' Core Setup
# This includes all of the F prime core components, and imports the make-system.
###
include("${CMAKE_CURRENT_LIST_DIR}/lib/fprime/cmake/FPrime.cmake")
# NOTE: register custom targets between these two lines
fprime_setup_included_code()


# This includes project-wide objects
include("${CMAKE_CURRENT_LIST_DIR}/project.cmake")

set_target_properties(Svc_FatalHandler PROPERTIES EXCLUDE_FROM_ALL TRUE)