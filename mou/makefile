#
# Makefile for Watcom/LIBC interface layer

PROJ      = mou
TRGT      = $(PROJ).lib
#32_BITS = 0
ADD_ASMOPT  = -I=$(MYDIR)..$(SEP)include;$(MYDIR)..$(SEP)macrolib
srcfiles  = $(p)mouroute$(e) $(p)debug$(e)

JWASM     = 1

TARGETS  = $(PATH)$(TRGT)

!include $(%ROOT)/mk/libsdos.mk

$(TARGETS): $(OBJS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library
