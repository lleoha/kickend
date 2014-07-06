noinst_PROGRAMS = kickend

kickend_SOURCES = amiga-crt0.S init.c main.c sys.c asm.h amiga.h amiga.ld 
kickend_LDFLAGS = -T $(top_srcdir)/src/amiga.ld

kickdir=$(datadir)/kickend
nodist_kick_DATA = kickend.rom

kickend.rom: kickend$(EXEEXT)
	$(AM_V_GEN)$(host_alias)-objcopy -O binary $< $@
	@$(host_alias)-size $<

CLEANFILES = kickend.rom
