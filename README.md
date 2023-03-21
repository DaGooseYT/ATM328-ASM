# ATM328-ASM
Custom bootloader and fuses designed specifically for the ATmega328p microcontroller, with complete programming interface support.

## Features
**Bootloader:** 
* Complete interface support including SPI/ISP, UART, and USB.
* All interfaces enable the device for master and slave configurations.
* Sleep mode for built-in hardware allows efficient power operation.
* Error handling.

**Fuses:** 
* Read/write status LED for UART and USB I/O.
* Basic power status LED indicator.

## Sample application
[prototype pic]

The electrical schematic and BoM for this prototype PCB can be found here.

**Flashing the MCU:**<br />
Requires a supported ISP programmer and avrdude flash software. A USBasp Chinese clone is used in this example.<br />

Using the sample prototype PCB, connect the USBasp to the correct pin headers. Refer to the schematic of the sample PCB for correct pin mapping.
[connected PCB pic]

Use the following commands to flash the bootloader and fuses to the device:

**Flash bootloader:**<br />
```sh
$ avrdude -c usbasp-clone -P usb -p m328p -U
```

**Flash fuses:**
```
$ avrdude -c usbasp-clone -P usb -p m328p -U
```

**Notice: Windows users need a driver for USBasp and other similar programmers.**


## Compilation
Requires AVRA assembler:
```
$ avra boot.asm -o boot.hex
$ avra fuse.asm -o fuse.hex
```

## License
The contents of this repo are licensed under the BSD 3-clause open-source software license. Any images are licensed under CC BY-SA 3.0.
