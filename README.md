# ATM328-ASM
Custom bootloader designed specifically for the ATmega328p microcontroller, with complete programming interface support.

## Features
* Complete interface support including SPI/ISP, UART, and USB.
* All interfaces enable the device for master and slave configurations.
* Sleep mode for built-in hardware allows efficient power operation.
* Error handling.
* Read/write status LED for UART and USB I/O.
* Basic power status LED indicator.

## Sample application
<img src="https://github.com/DaGooseYT/ATM328-ASM/blob/main/pic/3.png" width="534"></img>

The electrical schematic and BoM for this prototype PCB can be found in `/prototype`.

## Flashing the MCU
Requires a supported ISP programmer and avrdude flash software. A USBasp Chinese clone is used in this example.<br />

Using the sample prototype PCB, connect the USBasp to the correct pin headers. Refer to the schematic of the sample PCB for correct pin mapping.<br /><br />
<img src="https://github.com/DaGooseYT/ATM328-ASM/blob/main/pic/1.png" width="534"></img>

Use the following commands to flash the bootloader to the MCU:<br />

```
avrdude.exe -c usbasp-clone -P usb -p m328p -B 8 -u -e -U lock:w:0x3F:m -v
avrdude.exe -c usbasp-clone -P usb -p m328p -u -U efuse:w:0xFD:m -v
avrdude.exe -c usbasp-clone -P usb -p m328p -u -U hfuse:w:0xDC:m -v
avrdude.exe -c usbasp-clone -P usb -p m328p -u -U lfuse:w:0xFF:m -v 
avrdude.exe -c usbasp-clone -P usb -p m328p -U flash:w:ATM328-ASM.hex -v
avrdude.exe -c usbasp-clone -P usb -p m328p -U lock:w:0x0F:m -v
```

**Notice: A driver may be required for your programmer to work.**


## Compilation
Use AVRASM2 assembler (Atmel Studio).

## License
The contents of this repo are licensed under the BSD 3-Clause open-source software license. Any images are licensed under CC BY-SA 3.0.
