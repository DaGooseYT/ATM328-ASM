# ATM328-ASM
An AVR bootloader designed specifically for the ATmega328p 8-bit MCU, with SPI programming interface support.<br />
**This implementation has not been fully tested for confirmed functionality.**

## Features
* Lightweight and fast.
* Error handling.
* Error status LED indicator.
* Ready/on status LED indicator.

## Sample application
<img src="https://github.com/DaGooseYT/ATM328-ASM/blob/main/pic/3.png" width="534"></img>

The electrical schematic and BoM for this prototype PCB can be found in `/prototype`.

## Flashing the MCU
Requires a supported ISP programmer and avrdude flash software. A USBasp Chinese clone is used in this example.<br />

Using the sample prototype PCB, connect the USBasp to the correct pin headers. Refer to the schematic of the prototype for correct pin mapping.<br /><br />
<img src="https://github.com/DaGooseYT/ATM328-ASM/blob/main/pic/1.png" width="534"></img>

Use the following commands to flash the bootloader to the MCU:<br />

```
avrdude.exe -c usbasp-clone -P usb -p m328p -U lock:w:0x3f:m -U lfuse:w:0xff:m -U hfuse:w:0xde:m -U efuse:w:0xfd:m
avrdude.exe -c usbasp-clone -P usb -p m328p -U flash:w:ATM328-ASM.hex -U lock:w:0x0f:m
```

**Notice: A driver may be required for your programmer to work.**


## Compilation
Use AVRASM2 assembler (Atmel Studio).

## License
The contents of this repo are licensed under the BSD 3-Clause open-source software license. Any images are licensed under CC BY-SA 3.0.
