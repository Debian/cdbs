#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2006 Peter Eisentraut <petere@debian.org>

# Test debug package support

. testsuite_functions

options $@
setup_workdir

cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
include \$(_cdbs_package_root_dir)/1/class/autotools.mk.in
EOF
chmod +x $WORKDIR/debian/rules

cat <<EOF >>$WORKDIR/debian/control

Package: cdbs-testsuite-dbg
Architecture: any
Description: common build system test suite debug package
 This package is part of the testsuite for the CDBS build system.  If you've
 managed to install this, something has gone horribly wrong.
EOF

cat <<EOF >$WORKDIR/debian/cdbs-testsuite.install
debian/tmp/usr/bin/
EOF

cp -R autotools/* $WORKDIR

build_package

# check if debug package was generated correctly
dpkg -c $WORKDIR/../cdbs-testsuite-dbg_0.1_*.deb | grep -q /usr/lib/debug/usr/bin/main || return_fail

clean_workdir
return_pass
