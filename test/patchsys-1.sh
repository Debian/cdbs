#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2006 Peter Eisentraut <petere@debian.org>

# Test simple-patchsys

. testsuite_functions

options $@
setup_workdir

cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
include \$(_cdbs_package_root_dir)/1/rules/simple-patchsys.mk.in
EOF
chmod +x $WORKDIR/debian/rules

cp -R patches $WORKDIR/debian/

build_package

test -s $WORKDIR/dummy1 || return_fail
test -s $WORKDIR/dummy2 || return_fail

clean_workdir
return_pass
