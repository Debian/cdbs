#!/bin/bash -e
# -*- mode: sh; coding: utf-8 -*-
# Recursively build CDBS and sanity check the resulting package.
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
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

. testsuite_functions

# Check any command line options
options $@

# Setup the work environment
setup_workdir

cd ${SRCDIR}/test/workdir
mkdir cdbs
cd cdbs
(cd ${SRCDIR} && tar -c --exclude=CVS --exclude='*test/workdir*' --exclude='*debian/tmp*' -f - .) | tar xf -
# We build with nocheck for reasons that should be obvious.
DEB_BUILD_OPTIONS=nocheck build_package_1
cd ..
dpkg -c cdbs*.deb > list
grep "/usr/share/cdbs/1/rules/buildcore.mk" list 1>/dev/null

clean_workdir
# If we made it this far, then we passed!
return_pass
