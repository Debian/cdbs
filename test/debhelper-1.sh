#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2006 Peter Eisentraut <petere@debian.org>

# Test exclude functionality

. testsuite_functions

options $@
setup_workdir
cp ../COPYING $WORKDIR/README
cp ../COPYING $WORKDIR/TODO
touch $WORKDIR/test.orig

cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
DEB_CLEAN_EXCLUDE = .orig
DEB_COMPRESS_EXCLUDE = README
EOF
chmod +x $WORKDIR/debian/rules

build_package

test -f $WORKDIR/test.orig || return_fail
test -f $WORKDIR/debian/cdbs-testsuite/usr/share/doc/cdbs-testsuite/README || return_fail
test -f $WORKDIR/debian/cdbs-testsuite/usr/share/doc/cdbs-testsuite/TODO.gz || return_fail

clean_workdir
return_pass

