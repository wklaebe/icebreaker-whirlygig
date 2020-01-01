# icebreaker-whirlygig
a random number generator on an iCE40 UP5k FPGA

WARNING: although this RNG is "good enough" to the eye, it does not pass randomness test suites like "dieharder".
This is also the reason why I do not provide an UART to read randomness from the FPGA, but only output to the LED panel.
Possible reasons include inverter loops synchronizing to the same oscillation frequency,
which did not happen in the same way on the original whirlygig CPLD implementation.

Random data is output in one frame out of 256, all other frames are black only. Otherwise the panel would just appear flat grey.

Attributions:

* whirlygig.v: Reimplementation of a concept derived from http://git.warmcat.com/cgi-bin/cgit/whirlygig-cpld/, which has dropped off the internet by now.

* led-simple.v: original at https://github.com/kbob/icebreaker-candy/blob/master/include/led-simple.v, used under GPLv3

* icebreaker.pcf: original at https://github.com/kbob/icebreaker-candy/blob/master/icebreaker.pcf, used under GPLv3

* main.mk: original at https://github.com/icebreaker-fpga/icebreaker-examples/blob/master/main.mk

* Makefile: taken from examples at https://github.com/icebreaker-fpga/icebreaker-examples

Building:

nextpnr complains "ERROR: timing analysis failed due to presence of combinatorial loops, incomplete specification of timing ports, etc.".
I'd be happy for a solution / workaround / fix - if you have one, please submit a pull request!

`USE_ARACHNEPNR=1 make prog` works for me though.

