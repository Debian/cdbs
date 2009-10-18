#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2006 Peter Eisentraut <petere@debian.org>

# Test distutils arch package + multiple python versions + tarball

. testsuite_functions

options $@
setup_workdir

cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
DEB_TAR_SRCDIR=distutils-test-0.1
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/tarball.mk.in
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
include \$(_cdbs_package_root_dir)/1/class/python-distutils.mk.in
EOF
chmod +x $WORKDIR/debian/rules

cat >>$WORKDIR/debian/control <<EOF

Package: python2.3-cdbs-testsuite
Architecture: any
Description: common build system test suite (Python 2.3)
 This package is part of the testsuite for the CDBS build system.  If you've
 managed to install this, something has gone horribly wrong.

Package: python2.4-cdbs-testsuite
Architecture: any
Description: common build system test suite (Python 2.4)
 This package is part of the testsuite for the CDBS build system.  If you've
 managed to install this, something has gone horribly wrong.
EOF

# Make sure tarball is in place for this test.
test_tarballs
cp tarballs/distutils-test-0.1.tar.gz $WORKDIR

build_package

dpkg -c $WORKDIR/../python2.3-cdbs-testsuite_0.1_*.deb | grep -F -q /usr/lib/python2.3/site-packages/testing/foo.py || return_fail
dpkg -c $WORKDIR/../python2.4-cdbs-testsuite_0.1_*.deb | grep -F -q /usr/lib/python2.4/site-packages/testing/foo.py || return_fail

clean_workdir
return_pass
