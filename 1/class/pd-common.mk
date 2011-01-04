# -*- mode: makefile; coding: utf-8 -*-
# Copyright © 2010 IOhannes m zmölnig <zmoelnig@iem.at>
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
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

ifndef _cdbs_bootstrap
_cdbs_scripts_path ?= /usr/lib/cdbs
_cdbs_rules_path ?= /usr/share/cdbs/1/rules
_cdbs_class_path ?= /usr/share/cdbs/1/class
endif

ifndef _cdbs_class_pd_common
_cdbs_class_pd_common := 1
CDBS_BUILD_DEPENDS_class_pd_common ?= pd-pkg-tools
CDBS_BUILD_DEPENDS += , $(CDBS_BUILD_DEPENDS_class_pd_common)


include $(_cdbs_class_path)/langcore.mk$(_cdbs_makefile_suffix)
include $(_cdbs_rules_path)/buildcore.mk$(_cdbs_makefile_suffix)

cdbs_pd_common_nostrip_package = 
ifneq (,$(filter nostrip,$(DEB_BUILD_OPTIONS)))
 cdbs_pd_common_nostrip_package = yes
endif

# pd externals have the uncommon extension .pd_linux, which prevents them from
# being properly detected by dh_shlibdeps, so we do it manually
$(patsubst %,binary-predeb-IMPL/%,$(DEB_ALL_PACKAGES)) ::
	dpkg-shlibdeps $(shell find $(cdbs_curdestdir) -name "*.pd_linux") -Tdebian/$(cdbs_curpkg).substvars

# pd externals have the uncommon extension .pd_linux, which prevents them from
# being properly detected by dh_strip, so we do it manually
$(patsubst %,binary-strip-IMPL/%,$(DEB_ALL_PACKAGES)) :: 
	$(if $(cdbs_pd_common_nostrip_package),,strip --remove-section=.comment --remove-section=.note --strip-unneeded $(shell find $(cdbs_curdestdir) -name "*.pd_linux") )

# add pd/puredata/pd-myflavour to the dependencies of the resulting binaries
#$(patsubst %,install/%,$(DEB_ALL_PACKAGES)) :: install/%:
#	@echo 'Adding Pd dependencies to debian/$(cdbs_curpkg).substvars'
#	@echo "Pd-depends: $(PD_DEPENDS)"
#	@echo '$(call cdbs_expand_curvar,PD_DEPENDS,$(comma) )'
#	@echo '$(call cdbs_expand_curvar,PD_DEPENDS,$(comma) )'    | perl -0 -ne '$(cdbs_re_squash_extended_space); $(re_squash_commas_and_spaces); /\w/ and print "pd:Depends=$$_\n"'     >> debian/$(cdbs_curpkg).substvars

CDBS_DEPENDS_DEFAULT += $(PD_DEPENDS)

#endif _cdbs_class_pd_common
endif
