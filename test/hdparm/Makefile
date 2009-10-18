# Makefile for hdparm

# DESTDIR is for non root installs (eg packages, NFS) only!
DESTDIR =

binprefix = /
manprefix = /usr
exec_prefix = $(binprefix)
sbindir = $(exec_prefix)/sbin
mandir = $(manprefix)/share/man
oldmandir = $(manprefix)/man

CC = gcc
CFLAGS := -O2 -W -Wall -Wbad-function-cast -Wcast-align -Wpointer-arith -Wcast-qual -Wshadow -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -fkeep-inline-functions -Wwrite-strings -Waggregate-return -Wnested-externs -Wtrigraphs $(CFLAGS)


LDFLAGS = -s
INSTALL = install
INSTALL_DATA = $(INSTALL) -m 644
INSTALL_PROGRAM = $(INSTALL)

all: hdparm

hdparm: 
	echo "Dummy test file." > $@

install: all
	if [ -f $(DESTDIR)$(sbindir)/hdparm ]; then rm -f $(DESTDIR)$(sbindir)/hdparm ; fi 
	if [ -f $(DESTDIR)$(mandir)/man8/hdparm.8 ]; then rm -f $(DESTDIR)$(mandir)/man8/hdparm.8 ;\
	elif [ -f $(DESTDIR)$(oldmandir)/man8/hdparm.8 ]; then rm -f $(DESTDIR)$(oldmandir)/man8/hdparm.8 ; fi
	$(INSTALL_PROGRAM) hdparm $(DESTDIR)$(sbindir)/hdparm

clean:
	rm -f hdparm *.o core

