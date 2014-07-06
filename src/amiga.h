#ifndef KICKEND_AMIGA_H_
#define KICKEND_AMIGA_H_

#include <stdint.h>
#ifdef HAVE_CONFIG_H
#  include "config.h"
#endif


#define SERDATR (*((volatile uint16_t *) 0xdff018))
#define SERDAT  (*((volatile uint16_t *) 0xdff030))
#define SERPER  (*((volatile uint16_t *) 0xdff032))
#define DMACON  (*((volatile uint16_t *) 0xdff096))
#define BPLCON0 (*((volatile uint16_t *) 0xdff100))
#define BPL1DAT (*((volatile uint16_t *) 0xdff110))
#define COLOR00 (*((volatile uint16_t *) 0xdff180))

#endif
