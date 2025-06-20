# fprime-nucleo_h723zg-zephyr-reference F' project

## System Requirements
1. F Prime System Requirements listed [here](https://github.com/nasa/fprime/tree/14bac5f350fef9add6c58592c690ebdabfbc83c7?tab=readme-ov-file#system-requirements)
2. Zephyr dependencies listed [here](https://docs.zephyrproject.org/latest/develop/getting_started/index.html#install-dependencies)

## Prerequisites
1. Follow the [Hello World Tutorial](https://fprime.jpl.nasa.gov/latest/tutorials-hello-world/docs/hello-world/)
2. Follow the [Zephyr Getting Started Guide](https://docs.zephyrproject.org/latest/develop/getting_started/index.html). Ensure that the Zephyr SDK is installed.
3. Install the stm32 board manager. [This](https://github.com/fprime-community/fprime-arduino/blob/main/docs/arduino-cli-install.md) guide can be used.

## Initial project setup

> [!NOTE]
> The `setup.sh` script can be used to build and install all required dependencies for this project and assumes the prerequesite steps have been completed. This script has only been tested on MacOS. Bash is required to run this script. To run the script, run `bash setup.sh`. Be sure to activate the fprime-venv created by this script.

1. Clone the GitHub repository.
```sh
git clone https://github.com/CubeSTEP/fprime-nucleo_h723zg-zephyr-reference.git
```

2. Fetch git submodules
```sh
# In fprime-nucleo_h723zg-zephyr-reference
git submodule update --recursive init
```

3. In the project directory, create a virtual environment
```sh
# In fprime-nucleo_h723zg-zephyr-reference
python3 -m venv fprime-venv
```

4. Activate the virtual environment
```sh
# In fprime-nucleo_h723zg-zephyr-reference
# Linux & MacOS
source fprime-venv/bin/activate

# Windows
source fprime-venv/Scripts/activate
```

5. With the virtual environment activated, install the requirements
```sh
pip install -r requirements.txt
```

6. Navigate to the `zephyr-workspace` directory to set up zephyr
```sh
# In fprime-nucleo_h723zg-zephyr-reference
cd lib/zephyr-workspace

# Run the following commands
west update
west zephyr-export
```

## Building and Running the ReferenceDeployment Application
> [!Note]
> This step can be skipped if the setup.sh script is run. However, any changes made will require you to run `fprime-util build` and may require `fprime-util generate`

1. In order to build the ReferenceDeployment application, or any other F´ application, we first need to generate a build directory. This can be done with the following commands:

```sh
# In fprime-nucleo_h723zg-zephyr-reference
fprime-util generate
```

2. The next step is to build the ReferenceDeployment application's code.
```sh
# In fprime-nucleo_h723zg-zephyr-reference
fprime-util build
```

## Flashing the NUCLEO H723ZG development board
```sh
# In fprime-nucleo_h723zg-zephyr-reference

# Linux
sh ~/.arduino15/packages/STMicroelectronics/tools/STM32Tools/2.3.0/stm32CubeProg.sh -i swd -f build-fprime-automatic-zephyr/zephyr/zephyr.hex -c /dev/ttyACM0

# MacOS
sh ~/Library/Arduino15/packages/STMicroelectronics/tools/STM32Tools/2.3.0/stm32CubeProg.sh -i swd -f build-fprime-automatic-zephyr/zephyr/zephyr.hex -c /dev/cu.usbmodem142203 

# Windows
# TODO
```

> [!Note]
> Change `/dev/ttyACM0` (`/dev/cu.usbmodem141203` for MacOS) to the correct serial device connected to the device. To find the correct serial port, refer [here](https://github.com/ngcp-project/gcs-infrastructure/blob/d34eeba4eb547a5174d291a64b36eaa8c11369c8/Communication/XBee/docs/serial_port.md)

> [!Note]
> Two USBs connections are required. USB PWR is used to flash the development board and access the debug terminal, USER USB is used to connect to the f prime GDS

## Running the application and F' GDS

The following command will spin up the F' GDS as well as run the application binary and the components necessary for the GDS and application to communicate.

```sh
# In top level project directory
fprime-gds -n --dictionary ./build-artifacts/zephyr/fprime-zephyr-deployment/dict/ReferenceDeploymentTopologyDictionary.json --communication-selection uart --uart-device /dev/cu.usbmodem142101 --uart-baud 115200 
```

> [!Note]
> `/dev/cu.usbmodem142101` will likely need to be replaced with the correct port.