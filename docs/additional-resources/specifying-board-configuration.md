# Specifying Zephyr Board Configuration
This reference deployent can be used for any board running zephyr so long as the correct zephyr board configuration is provided. 

## Update the Zephyr West Configuration File

If your board is supported by Zephyr, the config file in `./lib/zephyr-workspace/.west/` may need to be updated in order to install the correct board configurations. This deployment by default only installs the board configurations for hal_stm32 boards.

The following is an example of a configuration for stm32 boards.
```
[zephyr]
base = zephyr

[manifest]
path = zephyr
group-filter = -hal,-debug
project-filter = -.*,+hal_stm32,+cmsis,+cmsis_6
```

More information on West Configuration files can be found [here](https://docs.zephyrproject.org/latest/develop/west/config.html)

> [!TIP]
> If your board is supported by Zephyr and you are unsure how to set up the configuration file, a temporary solution is to remove the config file and running `west update` to install all board configurations.

## Using Custom Board Configurations
Using a custom board configuration may require updating the CMakeLists.txt file. This repository appends the following board root which contains a board configuration for the STM32H753I-EVAL board.

```cmake
list(APPEND BOARD_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/lib/fprime-stm32h7-zephyr")
```

Make sure to update the path to match the location of your custom board configuration if needed. More information on creating custom board configurations can be found on zephyr's official documentation [here](https://docs.zephyrproject.org/latest/hardware/porting/board_porting.html).

## Update the settings.ini File
In order to specify the board to build for, update the `BOARD` option in the `settings.ini` file to the correct board name.


```ini
BOARD=nucleo_h723zg # Example for the NUCLEO-H723ZG, which is supported by zephyr
```

A list of supported boards can be found [here](https://docs.zephyrproject.org/latest/boards/index.html#).

# Return to the [Initial Setup Documentation][initial-setup]

<!-- Links -->
[initial-setup]: ../main-content/initial-setup.md