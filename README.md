# CEMU

(name in the works)

There are two parts to this project
(1) C++ Gameboy emulator
(2) FPGA emualtor

The C++ emulator is working. I created it to get a better understanding about how the internals of the emulator works. The FPGA emulator is in progress.

The FPGA emulator currently:

![](./display.gif)

Note: The rendering is done in C++ by reading the VRAM every tick and constructing a framebuffer and I have not done the sprites yet. A fully HDL PPU is coming soon. Also the green tinted colors, represents the window being drawn. Also the gif is sped up 8 times.

So progress.
