#!/bin/bash
# ==============================================================================
# "docs-src/init.sh" v1.0.1 | 2020/08/20 | by Tristano Ajmone
# Released into the Public Domain (https://unlicense.org)
# ------------------------------------------------------------------------------
# RUN ME WITH:
#   . ./init.sh
# OR WITH:
#   source ./init.sh
# ------------------------------------------------------------------------------
# This script prepends to $PATH the "./tools/" folder, giving it precedence over
# other paths in order to ensure that the binary dependencies inside "tools/"
# will be used instead of any system-wide versions present on the machine.
#
# This script was designed mainly for Windows OS, for which the Polygen-Docs
# repository offers a script to download precompiled binaries of all required
# third party tools to ensure that their exact intended version is used to build
# the documents, even is different (more reccent) versions of the same tools are
# already installed/available in the system.
#
# With OSs other than Windows, this script won't have any effect, unless the
# end user has manually setup the required binaries in the "tools/" folder.
# ==============================================================================

if [[ -v PolyEnv ]]
then
	echo -e "\e[30;1m------------------------------------------------"
	echo -e "\e[30;1mPolygen working environment already initialized!"
	echo -e "\e[30;1m------------------------------------------------\e[0m"
else
	# Check that script is being sourced:
	if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
	then
		echo -e "\e[31;1m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		echo -e "\e[31;1m*** ERROR *** This script must be sourced!"
		echo -e "\e[31;1mInvoke it with: \e[33;3msource ./init.sh"
		echo -e "\e[31;1m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\e[0m"
		exit 1
	fi
	echo -e "\e[32;1m--------------------------------------------"
	echo -e "\e[32;1mInitializing Polygen working environment ...\n"
	export PATH=$(pwd)/tools:$PATH
	export PolyEnv="Initialized"
	echo -e "\e[37;1mNow the binaries in the 'tools/' folder will"
	echo -e "\e[37;1mhave precedence over pre-existing versions."
	echo -e "\e[32;1m--------------------------------------------\e[0m"
fi
