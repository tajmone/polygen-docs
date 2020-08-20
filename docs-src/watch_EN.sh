#!/bin/bash
# ==============================================================================
# "docs-src/watch_EN.sh" v2.0.0 | 2020/08/20 | by Tristano Ajmone
# Released into the Public Domain (https://unlicense.org)
# ------------------------------------------------------------------------------
# Watch English "PML Spec" sources and rebuild HTML doc on changes dectection.
# ------------------------------------------------------------------------------
# In order to run this script you'll need to install "onchange" (Node.js):
#    https://www.npmjs.com/package/onchange
# ------------------------------------------------------------------------------

echo Now watching English Polygen docs source for changes...
onchange \
	'polygen-spec_EN*.markdown' \
	'polygen-spec_inc*.markdown' \
	'assets/polyman.css' \
	-- bash convert.sh en
