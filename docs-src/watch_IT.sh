#!/bin/bash
# ==============================================================================
# "docs-src/watch_IT.sh" v2.0.0 | 2020/08/20 | by Tristano Ajmone
# Released into the Public Domain (https://unlicense.org)
# ------------------------------------------------------------------------------
# Watch Italian "PML Spec" sources and rebuild HTML doc on changes dectection.
# ------------------------------------------------------------------------------
# In order to run this script you'll need to install "onchange" (Node.js):
#    https://www.npmjs.com/package/onchange
# ------------------------------------------------------------------------------

echo Now watching Italian Polygen docs source for changes...
onchange \
	'polygen-spec_IT*.markdown' \
	'polygen-spec_inc*.markdown' \
	'assets/polyman.css' \
	-- bash convert.sh it
