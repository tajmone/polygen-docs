#!/bin/bash
# ******************************************************************************
# *                      PolyGen Manual (EN) Build Script                      *
# *                  v1.0.0 | 2018/01/13 | by Tristano Ajmone                  *
# *                   Public Domain (http://unlicense.org/)                    *
# ******************************************************************************
echo Converting polygen-spec_EN to html5...
pp -import=assets/macros.pp \
           polygen-spec_EN.markdown \
| pandoc \
     -F pandoc-crossref \
     -F pandoc-citeproc \
     -f markdown \
     -t html5 \
    --template=assets/GitHub.html5 \
    --toc \
    --toc-depth=5 \
    --self-contained \
     -o polygen-spec_EN.html

echo Completed!
echo ------------------------------------------------------------------------------

