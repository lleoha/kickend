kickend
-------

Amiga 500 kickstart builder


Compilation
-----------

In order to compile sources from the repository you will need m68k toolchain and autotools.
```
autoreconf -vfi
./configure --host=m68k-elf
make
sudo make install
```
The kictstart replacement (kickend.rom) will be installed in the _DATADIR_/kickend (e.g. /usr/local/share/kickend/kickend.rom)
