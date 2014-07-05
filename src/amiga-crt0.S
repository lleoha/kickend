/**
 * crt0.S -- Simple startup code
 *
 * Copyright (c) 1995, 1996, 1998 Cygnus Support
 *
 * The authors hereby grant permission to use, copy, modify, distribute,
 * and license this software and its documentation for any purpose, provided
 * that existing copyright notices are retained in all copies and that this
 * notice is included verbatim in any distributions. No written agreement,
 * license, or royalty fee is required for any of the authorized uses.
 * Modifications to this software may be copyrighted by their authors
 * and need not follow the licensing terms described here, provided that
 * the new terms are clearly indicated on the first page of each file where
 * they apply.
 */

#include "asm.h"

.title "crt0.S for Amiga kickstart"

/*
 * Define an empty environment.
 */
.data  2
.align 2
SYM (environ): .long 0

.align  2
.text   2
/*
 * These symbols are defined in C code, so they need to always be
 * named with SYM because of the difference between object file formats.
 */

.extern SYM (main)
.extern SYM (atexit)
.extern SYM (exit)
.extern SYM (hardware_init_hook)
.extern SYM (software_init_hook)

.weak SYM (hardware_init_hook)
.weak SYM (software_init_hook)

/* 
 * These values are set in the linker script, so they must be
 * explicitly named here without SYM.
 */
.extern __stack
.extern _data
.extern __data_load
.extern _edata
.extern __bss_start
.extern _end

/*
 * set things up so application will run. This *must* be called _start.
 */
.global SYM (_start)
SYM (_start):
/*
 * See if user supplied their own stack (__stack != 0). If not, then
 * default to using the value of %sp as set by the ROM monitor
 */
    movel  IMM(__stack), a0
    cmpl   IMM(0), a0
    jbeq   1f
    movel  a0, sp
1:
/* set up initial stack frame */
    link  a6, IMM(-8)

/*
 * Disable ROM shadow 
 */
    moveb  IMM(3), 0xbfe201
    moveb  IMM(2), 0xbfe001

/*
 * copy data from ROM to RAM
 */
    lea   __data_load, a1
    lea   _data, a0
    lea   _edata, a2
2:
    cmpal a2, a0
    bccs  3f
    moveb (a1)+, (a0)+
    bras  2b
3:

/*
 * zero out the bss section.
 */
    lea    __bss_start, a0
    lea    _end, a1
4:
    cmpal  a1, a0
    bccs   5f
    clrb   (a0)+
    bras   4b
5:

/*
 * initialize target specific stuff. Only execute these
 * functions it they exist.
 */
    lea   SYM (hardware_init_hook), a0
    cmpl  IMM(0), a0
    jbeq  6f
    jsr   (a0)
6:

    lea   SYM (software_init_hook), a0
    cmpl  IMM(0), a0
    jbeq  7f
    jsr   (a0)
7:

/*
 * constructors and destructors initialization
 */
    movel  IMM (_fini),(sp)
    jsr    SYM (atexit)
    jsr    _init

/*
 * call the main routine from the application to get it going.
 * main (argc, argv, environ)
 * we pass argv as a pointer to NULL.
 */
    pea    0
    pea    SYM (environ)
    pea    sp@(4)
    pea    0
    jsr    SYM (main)   /* call to main */
    movel  d0, -(sp)

/*
 * drop down into exit in case the user doesn't. This should drop
 * control back to the ROM monitor, if there is one. This calls the
 * exit() from the C library so the C++ tables get cleaned up right.
 */
    jsr  SYM (exit)


.section  .vector_table,"a"
.global SYM (_vector_table)
SYM (_vector_table):
    dc.l    __stack                          /* 000 Initial Stack              */
    dc.l    _start                           /* 001 Reset                      */
