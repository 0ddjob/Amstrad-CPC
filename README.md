# Amstrad CPC
Amstrad CPC related projects.

## [CPC PLUS Floppy Adaptor](/CPC_Plus_Floppy_Adaptor)
An idea to convert the 6128 PLUS model's Centronics floppy connector to a more standard 26-way or 34-way pin header to connect a drive via a ribbon cable.<br>

![CPC PLUS Floppy Adaptor](/CPC_Plus_Floppy_Adaptor/CPC_Plus_Floppy_Adaptor_3D.png)

### Status
21-May-2026: test boards being fabricated

## [Dual ROM Adaptor for CPC464](/CPC464_Dual_ROM)
An idea for a no-cut adaptor board to allow two 32KB ROM images to be installed/switchable on a 64KB EPROM.  This means you could have the original 464 firmware/BASIC 1.0 and 664 (or 6718) firmware/BASIC 1.1 easily switchable.  Alternatively you could install a diagnostic ROM in one of the 32KB banks.<br>

Of course you would need to de-solder the original ROM and install this, but you wouldn't need to worry about cutting the PCB and wiring up pin 1.<br>

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

I've added dual DIN sockets ... 6-pin for original CPC and 8-pin for CPC PLUS ... with the idea that a simple DIN-to-DIN cable can be used to connect.  I've also added pass-through of the PLUS's stereo audio as well as the monochrome LUM signal from both machines.<br>

I've also added a buffer on the Pico VGA output stage as suggested by [WacKEDmaN](https://github.com/WacKEDmaN/VGA4CPC-Enhanced#optional-hardware-mods).<br>

For power I thought it easiest to use a 2.1mm splitter cable to power both the CPC and the converter board.<br>

![Brett's CPC-to-VGA board 3D](/VGA4CPC_Brett/RevB/VGA4CPC_Brett_RevB_3D.png)

I've designed a smaller (<100x100mm so cheaper to fab) CPC-only board as Rev. C.

![Brett's CPC-only board 3D](/VGA4CPC_Brett/RevC/VGA4CPC_Brett_RevC_3D.png)

### Status
22-May-2025: pending fab & testing
