# fprime-nucleo_h723zg-zephyr-reference F' project
> [!Note]
> This deployment targets the NUCLEO-H723ZG development board and has been verified on macOS and on Windows 11 using WSL (Ubuntu 22.04 LTS)

## System Requirements

- F Prime System Requirements listed [here](https://fprime.jpl.nasa.gov/latest/docs/getting-started/installing-fprime/#system-requirements)
- Zephyr dependencies listed [here](https://docs.zephyrproject.org/latest/develop/getting_started/index.html)
- Minimum required **CMake version: 3.27.0**

> If your system CMake is older than 3.27, it **must be upgraded**. On WSL, this must be often done manually.

>[!Note]
> For users using WSL please see important instructions below under section **WSL (Windows 11) Notes**

---

## Prerequisites
1. Follow the [Hello World Tutorial](https://fprime.jpl.nasa.gov/latest/tutorials-hello-world/docs/hello-world/)
2. Follow the [zephyr Getting Started Guide](https://docs.zephyrproject.org/latest/develop/getting_started/index.html) 
3. Install the stm32 board manager. [This](https://github.com/fprime-community/fprime-arduino/blob/main/docs/arduino-cli-install.md) guide can be used.

---

## Initial project setup
The setup.sh script can be run to build and install all required dependencies for this project and assumes the prerequisites steps have been completed.
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
# In top level project directory
sh ~/Library/Arduino15/packages/STMicroelectronics/tools/STM32Tools/2.3.0/stm32CubeProg.sh -i swd -f build-fprime-automatic-zephyr/zephyr/zephyr.hex -c /dev/cu.usbmodem142203 
```

> [!Note]
> `/dev/cu.usbmodem142203` will likely need to be replaced with the correct port. This can be found by running the following command: `ls -l /dev/cu.usb*`

> [!Note]
> Two USB connections are required. USB PWR is used to power and flash the development board and access the debug terminal, USER USB is used to connect to the F Prime GDS

## Running the application and F' GDS

The following command will spin up the F' GDS as well as run the application binary and the components necessary for the GDS and application to communicate.

```sh
# In top level project directory
fprime-gds -n --dictionary ./build-artifacts/zephyr/fprime-zephyr-deployment/dict/ReferenceDeploymentTopologyDictionary.json --communication-selection uart --uart-device /dev/cu.usbmodem142101 --uart-baud 115200 
```

> [!Note]
> `/dev/cu.usbmodem142101` will likely need to be replaced with the correct port. This can be found by running the following command: `ls -l /dev/cu.usb*`

## WSL (Windows 11) Notes
WSL doesn't natively have access to USB devices. To flash the board properly and allow the GDS to communicate with the deployment board via UART over USB, follow these one-time steps

1. On Powershell as administrator, install and run **usbipd-win**: 
Run Powershell as administrator 
```
winget install dorssel.usbipd-win 
```

2. On Powershell find your USB device:
```
usbipd list
```
> [!Note]
> You should see two STM32 devices listed with different BUSID's. One corresponds to the USB PWR and the other to USER USB.

3. On Powershell bind both devices to USBIPD in two seperate commands (as administrator):
```
usbipd bind --busid <BUSID_USB_PWR> --wsl
```

```
usbipd bind --busid <BUSID_USER_USB> --wsl
```

5. On WSL confirm visibility of USB device:
```
ls /dev/ttyACM*
```
> [!Note]
> On WSL, the device will usually appear as /dev/ttyACM0. You can check using ls /dev/ttyACM*

