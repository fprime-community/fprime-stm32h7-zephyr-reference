# Initial Project Setup

This guide will walk through the steps of setting up the reference deployment.

<!-- TODO: UPDATE REPO NAME -->
## 1. Clone the GitHub repository
Clone the GitHub repository onto your local machine.
```sh
git clone https://github.com/CubeSTEP/fprime-nucleo_h723zg-zephyr-reference.git
```

> [!NOTE]
> The `setup.sh` script can be used to build and install all required dependencies for this project and assumes the prerequesite steps have been completed. This script has only been tested on MacOS. Bash is required to run this script. To run the script, run `bash setup.sh`. Be sure to activate the fprime-venv created by this script. If this script is run successfully, the `Initial Project Setup` and `Building and Running the ReferenceDeployment Application` steps can be skipped.

## 2. Fetch git submodules
Install the required libraries for this deployment
```sh
# In fprime-stm32h7-zephyr-reference
git submodule update --recursive --init
```

> [!NOTE]
> If you have not installed the [Zephyr SDK](https://docs.zephyrproject.org/latest/develop/toolchains/zephyr_sdk.html#toolchain-zephyr-sdk), please install it with the following command:
> ```shell
> # In fprime-stm32h7-zephyr-reference
> cd ./lib/zephyr-workspace/zephyr
> west sdk install
> ```
> The Zephyr SDK only needs to be installed once.

## 3. Create a virtual environment
Create a virtual environment in the main project directory

```sh
# In fprime-stm32h7-zephyr-reference
python3 -m venv fprime-venv
```

## 4. Activate the virtual environment

```sh
# In fprime-stm32h7-zephyr-reference
# Linux, MacOS, & Windows WSL
source fprime-venv/bin/activate
```

## 5. Install python requirements
With the virtual environment activated, install the requirements
```sh
# In fprime-stm32h7-zephyr-reference (fprime-venv)
pip install -r requirements.txt
```

 > [!NOTE]
 > If you are not using the NUCLEO-H723ZG board, additional steps need to be taken. Please refer to the [Specifying Board Configuration][specifying-board-configuration] documentation for more information before continuing.


## 6. Get Zephyr Source Code
Navigate to the `zephyr-workspace` directory to set up zephyr. This deployment by default only installs zephyr source code for STM32 boards. If you are not using a stm32 board, the `config` file in `./lib/zephyr-workspace/.west/` will need to be updated. 
```sh
# In fprime-stm32h7-zephyr-reference
cd lib/zephyr-workspace

# Run the following commands
west update
west zephyr-export
```

# Next Steps: [Building, Flashing, and Running the Deployment][build-flash-run]

<!-- Links -->
[build-flash-run]: ./build-flash-run.md
[specifying-board-configuration]: ../additional-resources/specifying-board-configuration.md