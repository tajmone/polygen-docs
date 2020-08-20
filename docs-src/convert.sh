#!/bin/bash
# ==============================================================================
# "docs-src/convert.sh" v1.0.0 | 2020/08/20 | by Tristano Ajmone
# Released into the Public Domain (https://unlicense.org)
# ------------------------------------------------------------------------------
# Unified Polygen Docs conversion script supporting all documents locales.
# Invoke passing either a supported locale or "all" (to build all docs):
#
#    convert.sh <all|en|it>
#
# Parameters are case-insensitive.
# ==============================================================================

function showhelp() {
	echo -e "\e[37;1mThis script requires one parameter (either a supported locale or \"all\"):\n"
	echo -e "\e[37;1m   convert.sh <all|en|it>\e[0m"
}

function finished() {
	echo -e "\e[30;1m------------------------------------------------------------------------------"
	echo -e "\e[32;1m/// CONVERSION FINISHED ///\n\e[0m"
}

function convert() {
	echo -e "\e[30;1m------------------------------------------------------------------------------"
	echo -e "\e[34;1mNow converting: \e[33;1m$1\e[0m"
	pp -import=assets/macros.pp \
		$1 \
	|	pandoc \
			-F pandoc-crossref \
			-F pandoc-citeproc \
			-f markdown \
			-t html5 \
			--template=assets/GitHub.html5 \
			--toc \
			--toc-depth=5 \
			--self-contained \
			-o ${1%.*}.html
}

# Initialize working environment:
# ===============================
source ./init.sh

# Abort if no parameter was found:
# ================================
if [ $# -eq 0 ]; then
	echo -e "\e[31;1m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo -e "\e[31;1m*** ERROR *** Required parameter missing!"
	echo -e "\e[31;1m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\e[0m"
	showhelp
	exit 1
fi

# Issue warning for extra parameters:
# ===================================
if [ $# -gt 1 ]; then
	echo -e "\e[33;1m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo -e "\e[33;1m*** WARNING *** More than one parameter!"
	echo -e "\e[33;1mExtra parameter(s) will be ignored."
	echo -e "\e[33;1m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\e[0m"
fi

param=$(echo $1 | tr '[:upper:]' '[:lower:]')
nomatch=maybe
case $param in
	en) echo -e "\e[34;1mConverting English document:"
		convert "polygen-spec_EN.markdown"
		finished
		unset nomatch
		;;

	it) echo -e "\e[34;1mConverting Italian document:"
		convert "polygen-spec_IT.markdown"
		finished
		unset nomatch
		;;

	all) echo -e "\e[34;1mConverting documents of every locale:"
		convert "polygen-spec_EN.markdown"
		convert "polygen-spec_IT.markdown"
		finished
		unset nomatch
		;;
esac

# Handle invalid parameter error:
# ===============================
if [ $nomatch ]; then
	echo -e "\e[31;1m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo -e "\e[31;1m*** ERROR *** Invalid parameter: \e[33;1m$param"
	echo -e "\e[31;1m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\e[0m"
	showhelp
	exit 1
fi
