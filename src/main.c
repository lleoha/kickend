int x = 7;
int y;
static int z=9;

int main() {
    short *a = (void *) 0xdff000 + 0x096;
    short *b = (void *) 0xdff000 + 0x100;
    short *c = (void *) 0xdff000 + 0x110;
    short *d = (void *) 0xdff000 + 0x180;

    *a = 0x7fff;
    *b = 0x0200;
    *c = 0x0000;
    *d = 0x0888;

    return 0;
}
