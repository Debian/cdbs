# -*- mode: makefile; coding: utf-8 -*-
# Copyright © 2002,2003 Colin Walters <walters@debian.org>
# Copyright © 2009-2012, 2014, 2016 Jonas Smedegaard <dr@jones.dk>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

AUTOMAKE_OPTIONS = 1.8 foreign no-dist

BUILT_SOURCES =

edit = perl -p \
 -e 's,\@PACKAGE_VERSION\@,$(PACKAGE_VERSION),;' \
 -e 's,\#PATH_RULES\#,_cdbs_scripts_path ?= $(pkglibexecdir)\n_cdbs_rules_path ?= $(pkgdatadir)/1/rules\n_cdbs_class_path ?= $(pkgdatadir)/1/class,g;' \
 -e 's,\@libexecdir\@,$(libexecdir),g;' \
 -e 's,\@datadir\@,$(pkgdatadir),g;' \
 -e 's,\@prefix\@,$(prefix),g;'

%.mk: %.mk.in
	rm -f $@ $@.tmp
	$(edit) <$(srcdir)/$< >$@.tmp
	mv $@.tmp $@

all_mk_files = 1/rules/buildvars.mk \
 1/rules/buildcore.mk \
 1/rules/debhelper.mk \
 1/rules/simple-patchsys.mk \
 1/rules/dpatch.mk \
 1/rules/upstream-tarball.mk \
 1/rules/utils.mk \
 1/rules/tarball.mk \
 1/class/ant-vars.mk \
 1/class/ant.mk \
 1/class/autotools-vars.mk \
 1/class/autotools-files.mk \
 1/class/autotools.mk \
 1/class/cmake.mk \
 1/class/gnome.mk \
 1/class/langcore.mk \
 1/class/makefile-vars.mk \
 1/class/makefile.mk \
 1/class/pd.mk \
 1/class/perl-vars.mk \
 1/class/perl-build-vars.mk \
 1/class/perl-build.mk \
 1/class/perl-makemaker-vars.mk \
 1/class/perl-makemaker.mk \
 1/class/perlmodule-vars.mk \
 1/class/perlmodule.mk \
 1/class/python-vars.mk \
 1/class/python-autotools.mk \
 1/class/python-module.mk \
 1/class/python-distutils.mk \
 1/class/python-sugar.mk \
 1/class/qmake.mk \
 1/class/scons-vars.mk \
 1/class/scons.mk \
 1/class/waf.mk

all-local: $(all_mk_files) $(scripts_SCRIPTS)

CLEANFILES = $(all_mk_files)

class_DATA = $(wildcard 1/class/*.mk)
classdir = $(pkgdatadir)/1/class

rules_DATA = $(wildcard 1/rules/*.mk)
rulesdir = $(pkgdatadir)/1/rules

bin_SCRIPTS = scripts/cdbs-edit-patch
dist_man_MANS = scripts/cdbs-edit-patch.1

pkglibexec_SCRIPTS = \
 scripts/list-packages \
 scripts/license-miner \
 scripts/licensecheck2dep5 \
 scripts/waf-unpack

EXTRA_DIST = tests/clean.at \
 tests/auto.at \
 tests/auto-build.at \
 tests/auto-srcbuild.at \
 tests/auto-tar.at \
 tests/auto-tar-build.at \
 tests/auto-tar-lzma.at \
 tests/auto-udeb.at \
 tests/hdparm.at \
 tests/exclude.at \
 tests/auto-dbg.at \
 tests/auto-data.at \
 tests/auto-data-dbg.at \
 tests/auto-datadbg.at \
 tests/patchsys.at \
 tests/dist-py23.at \
 tests/dist-py2-tar.at \
 tests/dist-py3.at \
 tests/ant.at

@AX_GNU_AUTOTEST_DEFAULT@
