#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2003 Jeff Bailey <jbailey@debian.org>
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

# Test a builddir != srcdir autotools setup
# srcdir is not the root of the package

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
DEB_SRCDIR=src
DEB_BUILDDIR=build
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
include \$(_cdbs_package_root_dir)/1/class/autotools.mk.in
EOF
chmod +x $WORKDIR/debian/rules

# Put our simple autotools test environment in place.
mkdir $WORKDIR/src
cp -R autotools/* $WORKDIR/src

# Build the Package (This would've been hard to guess, right?)
build_package
# Clean up
clean_workdir
# If we made it this far, then we passed!
return_pass

