kickend
-------

Amiga 500 [kickstart](http://en.wikipedia.org/wiki/Kickstart_(Amiga)) replacement builder using [GCC](https://gcc.gnu.org/) and [newlib](https://sourceware.org/newlib/).


Compilation
-----------

In order to compile sources from the repository you will need m68k toolchain and autotools.
```
autoreconf -vfi
./configure --host=m68k-elf
make
sudo make install
```
The kictstart replacement (kickend.rom) will be installed in the _DATADIR_/kickend (e.g. `/usr/local/share/kickend/kickend.rom`)


Running
---------

The exemplary provided kickstart will set a background color of the screen to red and put "Hello" string to the serial console output. You can use any Amiga 500 emulator (e.g. [WinUAE](http://www.winuae.net/)) to test it out.
