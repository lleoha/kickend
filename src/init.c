typedef void (*__exc_handler_t)(void);

static __exc_handler_t *handlers = 0;

__attribute__ ((interrupt, noreturn))
void __dummy_exception_handler(void) {
    for(;;);
}

void software_init_hook() {
    /* setup exception handlers */
    int vec;
    for (vec = 2; vec < 256; ++vec) {
        handlers[vec] = __dummy_exception_handler;
    }
}
