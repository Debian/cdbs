#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2006 Peter Eisentraut <petere@debian.org>

# Test debug package support

. testsuite_functions

options $@
setup_workdir
echo foo >$WORKDIR/foo
echo bar >$WORKDIR/bar

cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
include \$(_cdbs_package_root_dir)/1/class/autotools.mk.in

DEB_DH_INSTALL_SOURCEDIR = debian/tmp

common-install-prehook-impl::
	install -D main \$(DEB_DESTDIR)/usr/bin/foo
	install -D main \$(DEB_DESTDIR)/usr/lib/bar
EOF
chmod +x $WORKDIR/debian/rules

echo 'usr/bin' >$WORKDIR/debian/cdbs-testsuite.install
echo 'usr/lib' >$WORKDIR/debian/cdbs-testsuite-data.install

cat >>$WORKDIR/debian/control <<EOF

Package: cdbs-testsuite-data
Architecture: any
Description: common build system test suite (data)
 This package is part of the testsuite for the CDBS build system.  If you've
 managed to install this, something has gone horribly wrong.

Package: cdbs-testsuite-dbg
Architecture: any
Description: common build system test suite debug package
 This package is part of the testsuite for the CDBS build system.  If you've
 managed to install this, something has gone horribly wrong.

Package: cdbs-testsuite-data-dbg
Architecture: any
Description: common build system test suite (data) debug package
 This package is part of the testsuite for the CDBS build system.  If you've
 managed to install this, something has gone horribly wrong.
EOF

cp -R autotools/* $WORKDIR

build_package

test -f $WORKDIR/debian/cdbs-testsuite-dbg/usr/lib/debug/usr/bin/foo || return_fail
test -f $WORKDIR/debian/cdbs-testsuite-data-dbg/usr/lib/debug/usr/lib/bar || return_fail

clean_workdir
return_pass
