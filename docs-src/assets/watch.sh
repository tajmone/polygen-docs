#!/bin/bash

# All command line options are defined in `build.sh`:
. ./build.sh

echo -e "\e[1;34m========================="
echo -e "\e[1;33mNow Watching Sass sources"
echo -e "\e[1;34m=========================\e[0m"

sass $src $dest --watch --style=$style \
	$smap --source-map-urls=$smapurls $smapembed
