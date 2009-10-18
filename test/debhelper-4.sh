#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2006 Peter Eisentraut <petere@debian.org>

# Test debhelper level 4 compat handling
# (contrast with level 5 test in debhelper-5.sh)

. testsuite_functions

options $@
setup_workdir
echo 4 >$WORKDIR/debian/compat
# This is an empty file. In debhelper level 4 this would be installed,
# in level 5 it shouldn't be.
touch $WORKDIR/DUMMY1
echo >$WORKDIR/DUMMY2

cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
DEB_INSTALL_DOCS_ALL += DUMMY1 DUMMY2
EOF
chmod +x $WORKDIR/debian/rules

build_package

test -f $WORKDIR/debian/cdbs-testsuite/usr/share/doc/cdbs-testsuite/DUMMY1 || return_fail
test -f $WORKDIR/debian/cdbs-testsuite/usr/share/doc/cdbs-testsuite/DUMMY2 || return_fail
test $(cat $WORKDIR/debian/compat) -eq 4 || return_fail

clean_workdir
return_pass
