# Amstrad CPC
Amstrad CPC related projects.

## [CPC PLUS Floppy Adaptor](/CPC_Plus_Floppy_Adaptor)
An idea to convert the 6128 PLUS model's Centronics floppy connector to a more standard 26-way or 34-way pin header to connect a drive via a ribbon cable.<br>

![CPC PLUS Floppy Adaptor](/CPC_Plus_Floppy_Adaptor/CPC_Plus_Floppy_Adaptor_3D.png)

### Status
21-May-2026: test boards being fabricated

## [Dual ROM Adaptor for CPC464](/CPC464_Dual_ROM)
An idea for a no-cut adaptor board to allow two 32KB ROM images to be installed/switchable on a 64KB EPROM.  This means you could have the original 464 firmware/BASIC 1.0 and 664 (or 6128) firmware/BASIC 1.1 easily switchable.  Alternatively you could install a diagnostic ROM in one of the 32KB banks.<br>

Of course you would need to de-solder the original ROM and install this, but you wouldn't need to worry about cutting the PCB and wiring up pin 1, and you caught just reinstall the original ROM.<br>

![Dual ROM 3D](/CPC464_Dual_ROM/CPC464_Dual_ROM_3D.png)

### Status
21-May-2026: test boards being fabricated

## [Amstrad CPC Troubleshooting Keyboard](/Amstrad_CPC_Keyboard)
Started off as a quick'n'dirty keyboard for my 2nd CPC664 motherboard that's missing the top case/keyboard, then morphed to a generic CPC keyboard that could be used for troubleshooting naked motherboards.<br>

### Status
25-Jul-2025: work in progress<br>

## [Easy Add on Projects for Amstrad CPC](/Easy-Add-on-Projects-for-Amstrad-CPC)
Trying out hardware projects from the book.

## [VGA4CPC](/VGA4CPC_Brett)
A modification of [grzegorz_gr's original design](https://github.com/grzegorz-gr/vga4cpc) to use with [WacKEDmaN's enhanced firmware](https://github.com/WacKEDmaN/VGA4CPC-Enhanced).<br>

- Rev. A: original re-design of grzegorz-gr's original, adding 6-pin & 8-pin DIN input sockets plus 3.5mm audio pass-through & 2.1mm DC power input
- Rev. B: added buffer on VGA output as suggest by [WacKEDmaN](https://github.com/WacKEDmaN/VGA4CPC-Enhanced#optional-hardware-mods), pass-through for B&W LUM signal, extra push button & breakout of spare GPIOs
- Rev. C: removed CPC PLUS 8-pin DIN to reduce board size (<100x100mm) for cheaper fabrication, adjusted resistor values
- Rev. D: added the CPC PLUS 8-pin DIN back in plus 3.5mm stereo audio output, remaining under 100x100mm
- Rev. E: swapped TLV3212 (SOIC-8) comparator for TLV3232 (SSOP-8) as it's faster
- Rev. F: moved the [comparator to its own daughterboard](/Amstrad-CPC/VGA4CPC_Brett/Comparator_Board) (simplifies circuit routing), switched to 5V logic (Pico 2 required), also switching the 74LVC245 (SMD) to 74HCT245 (THT)

![Brett's CPC-only board 3D](/VGA4CPC_Brett/RevC/VGA4CPC_Brett_RevC_3D.png)

![Brett's CPC-to-VGA board 3D](/VGA4CPC_Brett/RevF/VGA4CPC_Brett_RevF_3D.png)

### Status
22-May-2025: Rev. C pending fab & testing

## [CPC DIN to VGA](/CPC_DIN-to-VGA)
This is just a very simple connector converter - convert the CPC/CPC PLUS DIN to VGA, with also an RCA for the B&W LUM signal and 3.5mm stereo socket for the PLUSs' audio output.<br>

The idea is that you can then more easily plug it into a device with a VGA socket (like GBS8200) for actual signal conversion.<br>

![CPC DIN to VGA converter 3D](/CPC_DIN-to-VGA/CPC_DIN-to-VGA_3D.png)

## [Laserwarp](/Laserwarp)
Laserwarp was the first game, with Map Rally, that we got with our green screen Amstrad CPC464 so I have fond memories.<br>

![Laserwarp sprite](/Laserwarp/Sprites/sprite_67_65B7_16x16.png)

I thought it might be interesting to try out Claude to disassemble and delve into how the game works.<br>
