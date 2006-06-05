dnl -*- mode: autoconf; coding: utf-8 -*-
dnl Configury for CDBS
dnl Copyright © 2002,2003 Colin Walters <walters@debian.org>
dnl
dnl This program is free software; you can redistribute it and/or
dnl modify it under the terms of the GNU General Public License as
dnl published by the Free Software Foundation; either version 2, or (at
dnl your option) any later version.
dnl
dnl This program is distributed in the hope that it will be useful, but
dnl WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
dnl General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License
dnl along with this program; if not, write to the Free Software
dnl Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
dnl 02111-1307 USA.

AC_INIT(cdbs, 0.4.7)
AC_CONFIG_SRCDIR(1/rules/buildcore.mk.in)
AM_INIT_AUTOMAKE

AC_MSG_CHECKING([whether 'make' is GNU Make])
if ! make --version 2>&1 | grep -q "GNU Make"; then
  AC_MSG_RESULT([no])
  AC_MSG_ERROR([you must use GNU Make])
fi
AC_MSG_RESULT([yes])

AM_MAINTAINER_MODE

AC_PATH_PROG(PERL, [perl])
if test "x$PERL" == "x"; then
  AC_MSG_ERROR([you must have Perl 5 installed])
fi

AC_PATH_PROG(PYTHON, [python])
if test "x$PYTHON" == "x"; then
  AC_PATH_PROG(PYTHON, [python2.2])
fi
AM_CONDITIONAL(HAVE_PYTHON, test x"$PYTHON" != x)

AC_CONFIG_FILES([Makefile scripts/list-packages test/Makefile])

AC_CONFIG_COMMANDS([list-packages],
                   [chmod +x scripts/list-packages])

AC_OUTPUT
