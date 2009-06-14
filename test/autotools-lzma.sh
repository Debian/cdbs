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

# Test a tarball autotools setup with lzma

# Bring in the testsuite functions
. testsuite_functions

# Check any command line options
options $@

# Setup the work environment
setup_workdir

# Create the debian/rules file
cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
DEB_TAR_SRCDIR=autotools-test-0.1
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
include \$(_cdbs_package_root_dir)/1/class/autotools.mk.in
include \$(_cdbs_package_root_dir)/1/rules/tarball.mk.in
EOF
chmod +x $WORKDIR/debian/rules

# Make sure tarball is in place for this test.
test_tarballs
gzip -d -c tarballs/autotools-test-0.1.tar.gz | lzma - > $WORKDIR/autotools-test-0.1.tar.lzma

# Build the Package (This would've been hard to guess, right?)
build_package
# Clean up
clean_workdir
# If we made it this far, then we passed!
return_pass

