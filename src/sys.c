#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/times.h>
#include <sys/wait.h>
#include <unistd.h>
#include <signal.h>
#include <errno.h>
#undef errno
extern int errno;
#include "amiga.h"


int close(int fd) {
    errno = ENOSYS;
    return -1;
}

int execve(const char *filename, char *const argv[], char *const envp[]) {
    errno = ENOSYS;
    return -1;
}

pid_t fork(void) {
    errno = ENOSYS;
    return -1;
}

int fstat(int fd, struct stat *buf) {
    errno = ENOSYS;
    return -1;
}

pid_t getpid(void) {
    errno = ENOSYS;
    return -1;
}

int gettimeofday(struct timeval *tv, void *tz) {
    errno = ENOSYS;
    return -1;
}

int isatty(int fd) {
    errno = ENOSYS;
    return 0;
}

int kill(pid_t pid, int sig) {
    errno = ENOSYS;
    return -1;
}

int link(const char *oldpath, const char *newpath) {
    errno = ENOSYS;
    return -1;
}

off_t lseek(int fd, off_t offset, int whence) {
    errno = ENOSYS;
    return -1;
}

int mkdir(const char *pathname, mode_t mode) {
    errno = ENOSYS;
    return -1;
}

int open(const char *pathname, int flags, mode_t mode) {
    errno = ENOSYS;
    return -1;
}

ssize_t read(int fd, void *buf, size_t count) {
    errno = ENOSYS;
    return -1;
}

void* sbrk(ptrdiff_t incr) {
    extern char _end; /* Set by linker.  */
    static char *heap_end;
    char *prev_heap_end;

    if (heap_end == 0) {
        heap_end = &_end;
    }

   prev_heap_end = heap_end;
   heap_end += incr;

   return (void*) prev_heap_end;
}

int stat(const char *path, struct stat *buf) {
    errno = ENOSYS;
    return -1;
}

clock_t times(struct tms *buf) {
    errno = ENOSYS;
    return -1;
}

int unlink(const char *pathname) {
    errno = ENOSYS;
    return -1;
}

pid_t wait(int *status) {
    errno = ENOSYS;
    return -1;
}

ssize_t write(int fd, const void *buf, size_t count) {
    if (fd == STDOUT_FILENO) {
        int c;
        char *b = (char *) buf;
        for (c = 0; c < count; ++c, ++b) {
            uint16_t data = (*b & 0x00ff) | 0x0100;
            SERDAT = data;
            while ((SERDATR & (1 << 12)) == 0);
        }
        errno = 0;
        return c;
    } else {
        errno = ENOSYS;
        return -1;
    }
}

__attribute__((noreturn))
void _exit(int rc) {
  /* Convince GCC that this function never returns.  */
  for (;;);
}
