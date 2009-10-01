#!/bin/bash
# -*- mode: sh; coding: utf-8 -*-
# Copyright © 2006 Peter Eisentraut <petere@debian.org>

. testsuite_functions

options $@
setup_workdir

cat <<EOF >$WORKDIR/debian/rules
#!/usr/bin/make -f
include debian/testsuite.mk
include \$(_cdbs_package_root_dir)/1/rules/debhelper.mk.in
include \$(_cdbs_package_root_dir)/1/class/ant.mk.in

DEB_JARS := /tmp/nothing.jar
JAVA_HOME := /usr/lib/jvm/default-java
JAVACMD += -Dfoo=bar
EOF
chmod +x $WORKDIR/debian/rules

cp -R ant/* $WORKDIR

build_package
clean_workdir
return_pass
