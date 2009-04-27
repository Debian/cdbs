#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2006 Peter Eisentraut <petere@debian.org>
# Copyright © 2009 Jonas Smedegaard <dr@jones.dk>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
# 02111-1307 USA.

# Test distutils arch package + extra package w/ pysupport

. testsuite_functions

options $@
setup_workdir

cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
DEB_PYTHON_SYSTEM = pysupport
DEB_PYTHON_MODULE_PACKAGES = python-cdbs-testsuite
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
include \$(_cdbs_package_root_dir)/1/class/python-distutils.mk.in
DEB_PYTHON_DESTDIR = \$(CURDIR)/debian/\$(cdbs_curpkg)
EOF
chmod +x $WORKDIR/debian/rules

cat >>$WORKDIR/debian/control <<EOF

Package: python-cdbs-testsuite
Architecture: any
Description: common build system test suite
 This package is part of the testsuite for the CDBS build system.  If you've
 managed to install this, something has gone horribly wrong.
EOF

cp -R distutils/* $WORKDIR
sed -i 's/^#EXT#/     /g' $WORKDIR/setup.py
touch $WORKDIR/foo.c

build_package

dpkg -c $WORKDIR/../python-cdbs-testsuite_0.1_*.deb \
	| grep -q '/usr/share/py\(thon-support/python-cdbs-testsuite\|shared\)/testing/foo.py' \
	|| return_fail
for v in `pyversions -vs`; do
	dpkg -c $WORKDIR/../python-cdbs-testsuite_0.1_*.deb \
		| grep -q "/usr/lib/py\(thon-support/python-cdbs-testsuite\|shared\)/python$v/foo.so" \
		|| return_fail
done

clean_package
test -d $WORKDIR/build && return_fail

clean_workdir
return_pass
