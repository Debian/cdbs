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
clean_workdir
mkdir -p $WORKDIR/debian
cp debian/testsuite.mk $WORKDIR/debian

cp -R hdparm/* $WORKDIR

build_package
clean_workdir
return_pass

