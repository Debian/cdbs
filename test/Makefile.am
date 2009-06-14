## -*- mode: makefile; coding: utf-8 -*-
## Copyright © 2003 Jeff Bailey <jbailey@debian.org>
## Copyright © 2009 Jonas Smedegaard <dr@jones.dk>
##
## This program is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License as
## published by the Free Software Foundation; either version 2, or (at
## your option) any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
## 02111-1307 USA.

# Run these tests silently so we can see what fails
TESTS_ENVIRONMENT = TESTS_SILENT=true

EXTRA_DIST = testsuite_functions

TESTS = autotools-1.sh \
	autotools-2.sh \
	autotools-3.sh \
	autotools-4.sh \
	autotools-5.sh \
	recursive.sh \
	udeb-1.sh \
	hdparm.sh \
	debhelper-1.sh \
	debhelper-2.sh \
	debhelper-3.sh \
	debhelper-4.sh \
	debhelper-5.sh \
	debhelper-6.sh \
	debhelper-7.sh \
	patchsys-1.sh \
	list-missing-1.sh \
	distutils-1.sh \
	distutils-2.sh \
	distutils-3.sh \
	distutils-4.sh \
	distutils-5.sh \
	distutils-6.sh \
	distutils-7.sh \
	distutils-8.sh \
	ant-1.sh

TARBALLS = tarballs/autotools-test-0.1.tar.gz \
	tarballs/distutils-test-0.1.tar.gz

check-local: tarballs

tarballs: $(TARBALLS)

clean-local:
	rm -rf workdir cdbs.build

distclean-local:
	rm -rf tarballs

tarballs/autotools-test-0.1.tar.gz:
	-mkdir tarballs
	rm -rf cdbs.build
	mkdir cdbs.build
	cd cdbs.build && ../autotools/configure
	$(MAKE) -C cdbs.build dist
	mv cdbs.build/autotools-test-0.1.tar.gz tarballs
	rm -rf cdbs.build

tarballs/distutils-test-0.1.tar.gz:
	-mkdir tarballs
	cd distutils && ./setup.py sdist
	mv distutils/dist/distutils-test-0.1.tar.gz tarballs
	rm -rf distutils/dist

