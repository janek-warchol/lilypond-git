#
# project  LilyPond -- the musical typesetter
# title	   user changeable settings
# file	   make/User.make
#
# Copyright (c) 1997 by    
#   	Jan Nieuwenhuizen <jan@digicash.com>
#	Han-Wen Nienhuys <hanwen@stack.nl>

# this still sux
# will be split into CFLAGS/EXTRA_CFLAGS etc, 
# so that defineable generically and per module

# you-re using a i386, eh?
#
#PROFILEFLAG=-pg
#

# optimization and debugging:
#
# if defined (=not commented-out), debugging flag is ignored!
OPTIFLAG=-DNDEBUG -DNPRINT -O2
#
DEBUGFLAG=-g
#

# turn off -pipe if linker doesn't support it
# 
# USER_CXXFLAGS=-pipe -Wall -W   -Wmissing-prototypes
# added two warnings that are treated by cygwin32's gcc 2.7.2 as errors.
# huh, but still, no warnings even provoced with linux's gcc 2.7.2.1?
USER_CXXFLAGS=-pipe -Wall -W -Wmissing-prototypes -Wmissing-declarations -Wconversion

#
# -lefence = ElectricFence.
#
# ElectricFence is a memory debugger which uses the 
# VM hardware to trap malloc/free errors.
#

EXTRALIB+= #-lefence

