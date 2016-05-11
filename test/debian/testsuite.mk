# Copyright © 2003 Jeff Bailey <jbailey@debian.org>
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

# cdbs uses itself to build itself.
_cdbs_package_root_dir = $(CURDIR)/../../..
_cdbs_scripts_path = $(_cdbs_package_root_dir)/scripts
_cdbs_rules_path = $(_cdbs_package_root_dir)/1/rules
_cdbs_class_path = $(_cdbs_package_root_dir)/1/class
_cdbs_makefile_suffix = .in
