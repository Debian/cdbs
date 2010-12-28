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
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Test distutils indep package w/ dh_python3

. testsuite_functions

options $@
setup_workdir

cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
include \$(_cdbs_package_root_dir)/1/class/python-distutils.mk.in
EOF
chmod +x $WORKDIR/debian/rules

sed -i \
	-e 's/Package: cdbs-testsuite/Package: python3-cdbs-testsuite/' \
	-e 's/Architecture: any/Architecture: all/' \
	$WORKDIR/debian/control

cp -R distutils/* $WORKDIR

build_package

dpkg -c $WORKDIR/../python3-cdbs-testsuite_0.1_*.deb \
	| grep -q '/usr/lib/python3/dist-packages/testing/foo.py' \
	|| return_fail

clean_workdir
return_pass
