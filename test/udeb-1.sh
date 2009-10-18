#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2003 Colin Walters <walters@debian.org>
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

# Test a tarball autotools setup builddir != srcdir

# Bring in the testsuite functions
. testsuite_functions

# Check any command line options
options $@

# Setup the work environment
setup_workdir

# Create the debian/rules file
cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
include \$(_cdbs_package_root_dir)/1/class/autotools.mk.in
EOF
chmod +x $WORKDIR/debian/rules

cat >$WORKDIR/debian/control <<EOF
Source: cdbs-testsuite
Section: debian-installer
Priority: optional
Maintainer: Colin Walters <walters@debian.org> 
Standards-Version: 3.6.0

Package: cdbs-udeb
XC-Package-Type: udeb
Architecture: all
Description: common build system test suite udeb
 This package is the testsuite for the CDBS build system.  If you've 
 managed to install this, something has gone horribly wrong.
EOF

# Put our simple autotools test environment in place.
cp -R autotools/* $WORKDIR
build_package
test -f $WORKDIR/../cdbs-udeb_0.1_all.udeb || return_fail
clean_workdir
return_pass

