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

ifndef _cdbs_class_pd
_cdbs_class_pd := 1

PD_PKG_TOOLS_DEP_class_pd ?= pd

CDBS_BUILD_DEPENDS_class_pd ?= $(PD_PKG_TOOLS_DEP_class_pd)
CDBS_BUILD_DEPENDS += , $(CDBS_BUILD_DEPENDS_class_pd)

PD_DEPENDS_class_pd ?= $(PD_PKG_TOOLS_DEP_class_pd)
PD_DEPENDS += , $(PD_DEPENDS_class_pd)

include /usr/share/pd-pkg-tools/1/class/pd-common.mk
endif

