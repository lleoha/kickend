AM_CFLAGS = -Os

noinst_PROGRAMS = kickend

kickend_SOURCES = amiga-crt0.S init.c main.c sys.c asm.h amiga.ld
kickend_LDADD = -lc
kickend_LDFLAGS = -T $(top_srcdir)/src/amiga.ld

kickdir=$(datadir)/kickend
nodist_kick_DATA = kickend.rom

kickend.rom: kickend$(EXEEXT)
	$(host_alias)-objcopy -O binary $< $@

CLEANFILES = kickend.rom
