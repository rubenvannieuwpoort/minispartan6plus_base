miniSpartan6+ sample project
============================

This repository is meant to be a ready-to-go starting project for the miniSpartan6+. Setting up a project for a dev board can be quite tedious, so I figure it'd faster to do it once and re-use this template for new projects.

This manual is written for Windows. I haven't tried to program the miniSpartan 6+ on Linux, but it *should* work in a similar way, since both Xilinx ISE WebPACK and xc3sprog are available for Linux as well.


Prerequisites
-------------

  1. Have [Xilinx ISE WebPACK](https://www.xilinx.com/products/design-tools/ise-design-suite/ise-webpack.html) installed. You need to register, but the program itself is free to use. Note that the Spartan 6 FPGA which is on the miniSpartan6+ is not supported by the newer Vivado Design Suite, so you really need Xilinx ISE, even though Xilinx recommends new projects to use Vivado Design Suite. Download it [here](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive-ise.html).
  2. Have [xc3sprog](http://xc3sprog.sourceforge.net/), which is a commandline utility to program FPGA's. You can download it [here](https://sourceforge.net/projects/xc3sprog/files/latest/download).


How to build this project
-------------------------

  1. Clone this project:

    git clone https://github.com/rubenvannieuwpoort/minispartan6plus_base

  2. Open the project by doubleclicking on minispartan6+.xise, or open Xilinx ISE WebPACK and open the file from there.
  3. In the design pane on the left, make sure that 'implementation' is selected. In the second window from the top (the one under the message 'no processes running'), there should be a text that says 'Generate Programming File' (you might need to scroll down). Doubleclick this and wait until the process is done. A bitstream file main.bit should be generated in the 'work' folder.

How to program the miniSpartan 6+
---------------------------------

You should have followed the previous instructions on how to build this project and obtain the bitstream, called main.bit. Now, connect the dev board to your PC with the USB cable and run:

    xc3sprog -c ftdi path/to/main.bit

This will program the bitstream to the dev board, which will start to run your design. The design will be lost when you power down the dev board. To make the design persistent, so that the dev board starts running it every time it powers up, you need to store the design in the flash memory. For this, you need the FPGA to temporarily function as a bridge between the SPI interface and the flash memory. For this, download [this bitstream](https://github.com/rubenvannieuwpoort/files/blob/master/lx25_flash.bit) which configures the FPGA to do exactly this. Note that this bitstream is only meant for the Spartan 6 LX25, and should not be used for other models (not even for other Spartan 6 models).

Now run:

    xc3sprog -c ftdi spi2flash.bit
    xc3sprog -c ftdi -I main.bit

The dev board will not start using your design until the next startup. If you want to run it directly, simply run

    xc3sprog -c ftdi main.bit

again, after programming your design to flash memory.

It can be useful to make one of more scripts for programming the miniSpartan6+.

Troubleshooting
---------------

If your invocation of `xc3sprog` shows an error similar to:
```
Could not open FTDI device (using libftdi): device not found
FTD2XX Open failed
```

There might be something wrong with your USB drivers. I typically resolve this by downloading [Zadig](https://zadig.akeo.ie/).

For me, after choosing `Options -> List All Devices` the miniSpartan6+ shows up as `Dual RS232-HS (Interface 0)` and `Dual RS232-HS (Interface 1)`. For me `libusb-win32` and `libusbK` seem to work with `xc3sprog`, while `WinUSB` and `USB Serial (CDC)` don't.

Note that when I tried the different drivers, the process seems a bit flaky. Sometimes I can't get `xc3sprog` to work anymore even though I have `libusb-win32` and `libusbK` installed. Restarting Zadig, re-connecting the dev board, and re-installing `libusb-win32` or `libusbK` seems to fix it, though.
