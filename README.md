# fprime-nucleo_h723zg-zephyr-reference F' project

## Prerequisites
1. Follow the [Hello World Tutorial](https://fprime.jpl.nasa.gov/latest/tutorials-hello-world/docs/hello-world/)
2. Follow the [zephyr Getting Started Guide](https://docs.zephyrproject.org/latest/develop/getting_started/index.html) 
3. Install the stm32 board manager. [This](https://github.com/fprime-community/fprime-arduino/blob/main/docs/arduino-cli-install.md) guide can be used.

## Initial project setup
The setup.sh script can be run to build and install all required dependencies for this project
```sh
bash setup.sh
```

Activate the created virtual environment
```sh
# In top level project directory
source fprime-venv/bin/activate
```
## Building and Running the ReferenceDeployment Application
> [!Note]
> This step can be skipped if the setup.sh script is run. However, any changes made will require you to run `fprime-util build` and may require `fprime-util generate`

In order to build the ReferenceDeployment application, or any other F´ application, we first need to generate a build directory. This can be done with the following commands:

```
cd ReferenceDeployment
fprime-util generate
```

The next step is to build the ReferenceDeployment application's code.
```
fprime-util build
```

## Flashing the NUCLEO H723ZG development board
```sh
sh ~/Library/Arduino15/packages/STMicroelectronics/tools/STM32Tools/2.3.0/stm32CubeProg.sh -i swd -f build-fprime-automatic-zephyr/zephyr/zephyr.hex -c /dev/cu.usbmodem142203 
```

> [!Note]
> `/dev/cu.usbmodem142203` will likely need to be replaced with the correct port. This can be found by running the following command: `ls -l /dev/cu.usb*`

> [!Note]
> Two USBs connections are required. USB PWR is used to flash the development board and access the debug terminal, USER USB is used to connect to the f prime GDS

## Running the application and F' GDS

The following command will spin up the F' GDS as well as run the application binary and the components necessary for the GDS and application to communicate.

```sh
fprime-gds -n --dictionary ./build-artifacts/zephyr/fprime-zephyr-deployment/dict/ReferenceDeploymentTopologyDictionary.json --communication-selection uart --uart-device /dev/cu.usbmodem142101 --uart-baud 115200 
```

> [!Note]
> `/dev/cu.usbmodem142203` will likely need to be replaced with the correct port. This can be found by running the following command: `ls -l /dev/cu.usb*`