#include "amiga.h"


typedef void (*__exc_handler_t)(void);

static __exc_handler_t *handlers = ((__exc_handler_t *) 0x000004) - 1; // hack "null pointer"

static void __dummy_exception_handler(void);

void hardware_init_hook(void);
void software_init_hook(void);


__attribute__ ((interrupt, noreturn))
static void __dummy_exception_handler() {
    for(;;);
}

void hardware_init_hook() {
    /* set serial port baudrate */
    SERPER = (0x7fff & ((3546895/115200) -1));
}

void software_init_hook() {
    /* setup exception handlers */
    int vec;
    for (vec = 2; vec < 256; ++vec) {
        handlers[vec] = __dummy_exception_handler;
    }
}
