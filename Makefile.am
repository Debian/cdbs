# -*- mode: makefile; coding: utf-8 -*-
# Copyright © 2002,2003 Colin Walters <walters@debian.org>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
# 02111-1307 USA.

AUTOMAKE_OPTIONS = 1.8 foreign no-dist

SUBDIRS = guide test

BUILT_SOURCES =

docdir = $(prefix)/share/doc/@PACKAGE@

edit = @PERLPATH@ -pe 's,\@PACKAGE_VERSION\@,@PACKAGE_VERSION@,;s,\@PATH_RULES\@,_cdbs_scripts_path ?= $(libexecdir)\n_cdbs_rules_path ?= $(pkgdatadir)/1/rules\n_cdbs_class_path ?= $(pkgdatadir)/1/class,g; s,\@libexecdir\@,$(libexecdir),g; s,\@datadir\@,$(pkgdatadir),g; s,\@prefix\@,$(prefix),g;'

%.mk: %.mk.in
	rm -f $@ $@.tmp
	$(edit) <$(srcdir)/$< >$@.tmp
	mv $@.tmp $@

all_mk_in_files := $(wildcard 1/class/*.mk.in 1/rules/*.mk.in)
all_mk_files := 1/rules/buildvars.mk		\
		1/rules/buildcore.mk		\
		1/rules/debhelper.mk		\
		1/rules/simple-patchsys.mk	\
		1/rules/dpatch.mk		\
		1/rules/utils.mk		\
		1/rules/tarball.mk		\
		1/class/ant-vars.mk		\
		1/class/ant.mk			\
		1/class/autotools-vars.mk	\
		1/class/autotools-files.mk	\
		1/class/autotools.mk		\
		1/class/docbookxml.mk		\
		1/class/gnome.mk		\
		1/class/kde.mk			\
		1/class/langcore.mk		\
		1/class/makefile-vars.mk	\
		1/class/makefile.mk		\
		1/class/perlmodule-vars.mk	\
		1/class/perlmodule.mk		\
		1/class/python-distutils.mk	\
		1/class/hbuild.mk

gen-dotty: gen-dotty.ml OCamlMakefile
	SOURCES=gen-dotty.ml LIBS=str RESULT=gen-dotty make -f OCamlMakefile native-code

docs/depgraph.png: gen-dotty $(all_mk_files)
	./gen-dotty $(all_mk_files) | @SPRINGGRAPHPATH@ -s0.5 > docs/depgraph.png

if HAVE_OCAML
if HAVE_SPRINGGRAPH
otherdeps=gen-dotty docs/depgraph.png
endif
endif

all-local: $(all_mk_files) $(otherdeps) $(scripts_SCRIPTS)

clean-local: 
if HAVE_OCAML
	SOURCES=gen-dotty.ml LIBS=str RESULT=gen-dotty make -f OCamlMakefile clean
endif
	rm -f docs/depgraph.png

CLEANFILES = $(all_mk_files)

class_DATA = $(wildcard 1/class/*.mk)
classdir = $(pkgdatadir)/1/class

rules_DATA = $(wildcard 1/rules/*.mk)
rulesdir = $(pkgdatadir)/1/rules

bin_SCRIPTS = scripts/cdbs-edit-patch
dist_man_MANS = scripts/cdbs-edit-patch.1

all_scripts_in_files := $(wildcard scripts/*.in)
scripts_SCRIPTS = scripts/list-packages
scriptsdir = $(libexecdir)

if HAVE_OCAML
if HAVE_SPRINGGRAPH
regulardocs_DATA = docs/depgraph.png
regulardocsdir = $(docdir)
endif
endif

if HAVE_DOCBOOK
DBKXSL=/usr/share/sgml/docbook/stylesheet/xsl/nwalsh/html/onechunk.xsl

dbksources = docs/why.dbk docs/cdbs.dbk
dbktargets = $(dbksources:%.dbk=%.html)

docbook_DATA = $(dbktargets)
docbookdir = $(docdir)
CLEANFILES += $(dbktargets)

%.html: %.dbk
	xsltproc --nonet $(DBKXSL) $<
	mv index.html $@
endif

example_DATA = $(wildcard examples/*.rules)
exampledir = $(docdir)/examples

EXTRA_DIST = $(all_mk_in_files) $(all_scripts_in_files) $(example_DATA) $(regulardocs_DATA) $(dbksources) gen-dotty.ml OCamlMakefile tests/pbuilder-all.sh
