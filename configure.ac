dnl -*- mode: autoconf; coding: utf-8 -*-
dnl Configury for CDBS
dnl Copyright © 2002,2003 Colin Walters <walters@debian.org>
dnl Copyright © 2016 Jonas Smedegaard <dr@jones.dk>
dnl
dnl This program is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation; either version 3, or (at your option)
dnl any later version.
dnl
dnl This program is distributed in the hope that it will be useful, but
dnl WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
dnl General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License
dnl along with this program.  If not, see
dnl <http://www.gnu.org/licenses/>.

AC_INIT(
	m4_esyscmd_s([grep -Pom1 '^Upstream-Name: \K.*' debian/copyright]),
	m4_esyscmd_s([grep -Pom1 '\(\K[^\)]*' debian/changelog]),
	m4_esyscmd_s([grep -Pom1 '^Upstream-Contact:.*<\K[^>]+' debian/copyright]),
	[cdbs],
	m4_esyscmd_s([grep -Pom1 '^Source: \K.*' debian/copyright]))
AC_CONFIG_SRCDIR(1/rules/buildcore.mk.in)
AM_INIT_AUTOMAKE
AM_MAINTAINER_MODE
AX_GNU_AUTOTEST(,,,[no])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
