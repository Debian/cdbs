#!/usr/bin/env python
from distutils.core import setup, Extension
setup(name="distutils-test",
      version = "0.1",
      author="jbailey",
      author_email="jbailey@debian.org",
      url="http://www.python.org/sigs/distutils-sig/",
#EXT# ext_modules=[Extension('foo', ['foo.c'])],
      #py_modules=['package'],
      packages = ["testing"],
      package_dir = {'testing':'src'}
     )

