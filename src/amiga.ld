OUTPUT_ARCH(m68k)
ENTRY(_start);

MEMORY {
  /* Chip SRAM.  */
  ram (rwx) : ORIGIN = 0x000000, LENGTH = 512K
  /* Flash ROM.  */
  rom (rx)  : ORIGIN = 0xfc0000, LENGTH = 256K
}

SECTIONS {
  .vector_table : {
    . = 0x000000;
    *(.vector_table)
    /*. = 0x000400;*/
  } >ram AT>rom

  .text : {
    *(.text .text.*)
    *(.gnu.linkonce.t.*)

    . = ALIGN(0x4);
    /* These are for running static constructors and destructors under ELF.  */
    KEEP (*crtbegin.o(.ctors))
    KEEP (*(EXCLUDE_FILE (*crtend.o) .ctors))
    KEEP (*(SORT(.ctors.*)))
    KEEP (*crtend.o(.ctors))
    KEEP (*crtbegin.o(.dtors))
    KEEP (*(EXCLUDE_FILE (*crtend.o) .dtors))
    KEEP (*(SORT(.dtors.*)))
    KEEP (*crtend.o(.dtors))

    . = ALIGN(0x4);
    KEEP (*crtbegin.o(.jcr))
    KEEP (*(EXCLUDE_FILE (*crtend.o) .jcr))
    KEEP (*crtend.o(.jcr))

    *(.rodata .rodata.*)
    *(.gnu.linkonce.r.*)
    *(.gcc_except_table) 
    *(.eh_frame)

    . = ALIGN(0x2);
    _init = . ;
    LONG (0x4e560000)	/* linkw %fp,#0 */
    *(.init)
    SHORT (0x4e5e)	/* unlk %fp */
    SHORT (0x4e75)	/* rts */

    _fini = . ;
    LONG (0x4e560000)	/* linkw %fp,#0 */
    *(.fini)
    SHORT (0x4e5e)	/* unlk %fp */
    SHORT (0x4e75)	/* rts */
    . = ALIGN(0x800);   /* align to a 2K dcache boundary */
    
    _etext = .;
    *(.lit)
    . = ALIGN(0x4);
  } >rom 

  /* Initialized data section.  */
  .data 0x400 :
  {
    _data = .;
    *(.got.plt) *(.got)
    *(.shdata);
    *(.data .data.*)
    *(.gnu.linkonce.d.*)
    _edata = .;
  } >ram AT>rom

  /* Zero-initialized data.  */ 
  .bss (NOLOAD) :
  {
    . = ALIGN(0x4);
    __bss_start = . ;
    *(.shbss)
    *(.bss .bss.*)
    *(.gnu.linkonce.b.*)
    *(COMMON)
    _end =  ALIGN (0x8);
    __end = _end;
  } >ram

  .int_ack_a500 : AT(ORIGIN(rom) + LENGTH(rom) - (2 * 7)) {
    SHORT(0x0019)
    SHORT(0x001A)
    SHORT(0x001B)
    SHORT(0x001C)
    SHORT(0x001D)
    SHORT(0x001E)
    SHORT(0x001F)
  }
}

PROVIDE (__stack = ORIGIN(ram) + LENGTH(ram));
PROVIDE (__data_load = LOADADDR(.data));
