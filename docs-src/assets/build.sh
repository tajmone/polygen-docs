#!/bin/bash

# The following vars are reused by the `watch.sh` script.
# We define all options (even if they enforce default values) so that we may
# quickly tweak them in one place if the need arises.

src=".\polyman.scss"
dest=".\polyman.css"

style=expanded    # expanded | compressed
smap=--source-map # --source-map | --no-source-map
smapurls=relative # relative | absolute
smapembed=--no-embed-sources # --embed-sources | --no-embed-sources

echo -e "\e[1;34m======================================================="
echo -e "\e[1;33mBuilding the Polygen Docs stylesheets from Sass sources"
echo -e "\e[1;34m======================================================="
echo -e "\e[0mSCSS input: \e[1;32m$src"
echo -e "\e[0mCSS output: \e[1;32m$dest\e[0m"

sass $src $dest --style=$style \
	$smap --source-map-urls=$smapurls $smapembed
