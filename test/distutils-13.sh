#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2014 Vasudev Kamath <kamathvasudev@gmail.com>
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

# Test distutils indep package with all dh_python2, dh_python3, dh_pypy

. testsuite_functions

options "$@"
setup_workdir

cat <<EOF > "$WORKDIR/debian/rules"
#!/usr/bin/make -f
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
include \$(_cdbs_package_root_dir)/1/class/python-distutils.mk.in
EOF

chmod +x "$WORKDIR/debian/rules"

cat <<EOF > "$WORKDIR/debian/control"
Source: cdbs-testsuite
Section: devel
Priority: optional
Maintainer: Jeff Bailey <jbailey@debian.org>
Standards-Version: 3.5.10

Package: python-cdbs-testsuite
Architecture: all
Description: common build system test suite
 This package is part of the testsuite for the CDBS build system.  If you've
 managed to install this, something has gone horribly wrong.

Package: python3-cdbs-testsuite
Architecture: all
Description: common build system test suite
 This package is part of the testsuite for the CDBS build system.  If you've
 managed to install this, something has gone horribly wrong.

Package: pypy-cdbs-testsuite
Architecture: all
Description: common build system test suite
 This package is part of the testsuite for the CDBS build system.  If you've
 managed to install this, something has gone horribly wrong.
EOF

cat <<EOF > "$WORKDIR/debian/pypy-cdbs-testsuite.install"
debian/tmp/usr/lib/pypy
EOF

cat <<EOF > "$WORKDIR/debian/python3-cdbs-testsuite.install"
debian/tmp/usr/lib/python3*
EOF

cat <<EOF > "$WORKDIR/debian/python-cdbs-testsuite.install"
debian/tmp/usr/lib/python2*
EOF

cp -R distutils/* "$WORKDIR"

build_package

dpkg -c "$WORKDIR"/../python-cdbs-testsuite_0.1_*.deb \
    | grep -q "/usr/lib/python$(pyversions -vr)/dist-packages/testing/foo.py" \
           || return_fail

dpkg -c "$WORKDIR"/../python3-cdbs-testsuite_0.1_*.deb \
    | grep -q '/usr/lib/python3/dist-packages/testing/foo.py' \
           || return_fail

dpkg -c "$WORKDIR"/../pypy-cdbs-testsuite_0.1_*.deb \
    | grep -q '/usr/lib/pypy/dist-packages/testing/foo.py' \
           || return_fail

clean_workdir
return_pass
