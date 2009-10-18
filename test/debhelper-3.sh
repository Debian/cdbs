#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2006 Peter Eisentraut <petere@debian.org>

# Test multiple binary packages

. testsuite_functions

options $@
setup_workdir
echo foo >$WORKDIR/foo
echo bar >$WORKDIR/bar

cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in

DEB_DH_INSTALL_SOURCEDIR = debian/tmp

common-install-prehook-impl::
	install -D foo \$(DEB_DESTDIR)/usr/lib/foo
	install -D bar \$(DEB_DESTDIR)/usr/share/bar
EOF
chmod +x $WORKDIR/debian/rules

echo 'usr/lib' >$WORKDIR/debian/cdbs-testsuite.install
echo 'usr/share' >$WORKDIR/debian/cdbs-testsuite-data.install

cat >>$WORKDIR/debian/control <<EOF

Package: cdbs-testsuite-data
Architecture: all
Description: common build system test suite (data)
 This package is part of the testsuite for the CDBS build system.  If you've
 managed to install this, something has gone horribly wrong.
EOF

build_package

test -f $WORKDIR/debian/cdbs-testsuite/usr/lib/foo || return_fail
test -f $WORKDIR/debian/cdbs-testsuite-data/usr/share/bar || return_fail

clean_workdir
return_pass
