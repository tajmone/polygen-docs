#!/bin/bash
# ******************************************************************************
# *                 Polygen Documentation Watch & Build Script                 *
# *                  v1.0.1 | 2018/01/14 | by Tristano Ajmone                  *
# *                   Public Domain (http://unlicense.org/)                    *
# ******************************************************************************
# In order to run this script you'll need multiwatch (Node.js):
#    https://www.npmjs.com/package/multiwatch
# ------------------------------------------------------------------------------

# Initialize work environment
# ===========================
source init.sh

# Wact source files for changes
# =============================
echo Now watching Polygen docs for changes...
multiwatch \
	polygen-spec_IT*.markdown \
	polygen-spec_inc*.markdown \
	assets/polyman.css \
	-e 'bash conv_IT.sh'

