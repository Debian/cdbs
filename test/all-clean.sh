#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2006 Peter Eisentraut <petere@debian.org>
# Copyright © 2016 Jonas Smedegaard <dr@jones.dk>

. testsuite_functions

options $@
setup_workdir

cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/class/ant.mk.in
include \$(_cdbs_package_root_dir)/1/class/autotools.mk.in
include \$(_cdbs_package_root_dir)/1/class/cmake.mk.in
include \$(_cdbs_package_root_dir)/1/class/dkms.mk.in
include \$(_cdbs_package_root_dir)/1/class/gnome.mk.in
include \$(_cdbs_package_root_dir)/1/class/pd.mk.in
include \$(_cdbs_package_root_dir)/1/class/perl-build.mk.in
include \$(_cdbs_package_root_dir)/1/class/perl-makemaker.mk.in
include \$(_cdbs_package_root_dir)/1/class/perlmodule.mk.in
include \$(_cdbs_package_root_dir)/1/class/python-autotools.mk.in
include \$(_cdbs_package_root_dir)/1/class/python-distutils.mk.in
include \$(_cdbs_package_root_dir)/1/class/python-sugar.mk.in
include \$(_cdbs_package_root_dir)/1/class/qmake.mk.in
include \$(_cdbs_package_root_dir)/1/class/scons.mk.in
#TODO include \$(_cdbs_package_root_dir)/1/class/waf.mk.in
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
#TODO include \$(_cdbs_package_root_dir)/1/rules/dpatch.mk.in
include \$(_cdbs_package_root_dir)/1/rules/simple-patchsys.mk.in
#TODO include \$(_cdbs_package_root_dir)/1/rules/tarball.mk.in
include \$(_cdbs_package_root_dir)/1/rules/upstream-tarball.mk.in
include \$(_cdbs_package_root_dir)/1/rules/utils.mk.in

JAVA_HOME := /usr/lib/jvm/default-java
DEB_PERL_SRCDIR = \$(DEB_BUILDDIR)
EOF
chmod +x $WORKDIR/debian/rules

cp -R autotools/* $WORKDIR

clean_package
clean_workdir
return_pass
