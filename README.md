# fprime-zephyr-reference project
This project is an implementation of F` on Zephyr RTOS. 

> [!Note]
> This deployment by default builds for the NUCLEO-H723ZG development board and has been verified on macOS and on Windows 11 using WSL (Ubuntu 22.04 LTS). 
> 

## System Requirements
- F Prime System Requirements listed [here](https://fprime.jpl.nasa.gov/latest/docs/getting-started/installing-fprime/#system-requirements)
- Zephyr dependencies listed [here](https://docs.zephyrproject.org/latest/develop/getting_started/index.html#install-dependencies)
- Minimum required **CMake version: 3.27.0**

## Prerequisites
1. Follow the [Hello World Tutorial](https://fprime.jpl.nasa.gov/latest/tutorials-hello-world/docs/hello-world/)
2. Follow the [Zephyr Getting Started Guide](https://docs.zephyrproject.org/latest/develop/getting_started/index.html). Ensure that the Zephyr's dependencies and SDK have been installed

## Table of Contents
1. [Initial Project Setup][initial-setup]
2. [Building, Flashing, and Running the Deployment][build-flash-run]

## Additional Resources
- [Using a Custom Board Configuration][custom-board]
- [Tested Board List][board-list]
- [Common Issues][common-issues]
- [WSL Notes][wsl-notes]

<!-- Links -->
[initial-setup]: ./docs/main-content/initial-setup.md
[board-dependencies]: ./docs/main-content/board-dependencies.md
[build-flash-run]: ./docs/main-content/build-flash-run.md
[custom-board]: ./docs/additional-resources/specifying-board-configuration.md
[board-list]: ./docs/additional-resources/board-list.md
[common-issues]: ./docs/additional-resources/common-issues.md
[wsl-notes]: ./docs/additional-resources/wsl-notes.md