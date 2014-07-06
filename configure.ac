#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([kickend], [0.1])
AM_INIT_AUTOMAKE([1.11 foreign subdir-objects silent-rules])
AM_SILENT_RULES([yes])
AC_CONFIG_SRCDIR([src/main.c])
AC_CONFIG_HEADERS([src/config.h])

# Checks for programs.
CFLAGS="-Os -m68000 -Wall $CFLAGS"
AM_PROG_AS
AC_PROG_CC

# Checks for header files.
AC_CHECK_HEADERS([stdint.h sys/time.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_MODE_T
AC_TYPE_OFF_T
AC_TYPE_PID_T
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T
AC_TYPE_UINT16_T
AC_CHECK_TYPES([ptrdiff_t])

AC_CONFIG_FILES([Makefile
                 src/Makefile])
AC_OUTPUT
