#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2003 Jeff Bailey <jbailey@debian.org>
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

# Test distutils indep package + tarball w/ pycentral

. testsuite_functions

options $@
setup_workdir

cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
DEB_TAR_SRCDIR=distutils-test-0.1
DEB_PYTHON_SYSTEM = pycentral
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/tarball.mk.in
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
include \$(_cdbs_package_root_dir)/1/class/python-distutils.mk.in
EOF
chmod +x $WORKDIR/debian/rules

sed -i \
	-e 's/Package: cdbs-testsuite/Package: python-cdbs-testsuite/' \
	-e 's/Architecture: any/Architecture: all/' \
	$WORKDIR/debian/control

# Make sure tarball is in place for this test.
test_tarballs
cp tarballs/distutils-test-0.1.tar.gz $WORKDIR

build_package

dpkg -c $WORKDIR/../python-cdbs-testsuite_0.1_all.deb | grep -q /usr/lib/python.../site-packages/testing/foo.py || return_fail

clean_workdir
return_pass
