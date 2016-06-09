#!/bin/sh

set -e

# workaround for included autotest snippets not taken into account
touch tests/testsuite.at

autoreconf --force --install

(set -e; cd tests/data/autotools/; autoreconf --force --install)

rm -rf autom4te.cache tests/data/autotools/autom4te.cache
