#include <stdint.h>
#include <stdio.h>
#include "amiga.h"


int main() {
    /* disable DMA */
    DMACON  = 0x7fff;

    /* set backgroud color to red */
    BPLCON0 = 0x0200;
    BPL1DAT = 0x0000;
    COLOR00 = 0x0f00;

    printf("Hello\r\n");
    return 0;
}
