#!/bin/bash

# RUN ME WITH:
#   . ./init.sh
# OR WITH:
#   source ./init.sh

if [[ -v PolyEnv ]]
then
	echo Polygen working environment already initialized!
else
	# Check that script is being sourced:
	if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
	then
		echo ERROR -- You must run me with:
		echo . ./init.sh
		exit 1
	fi
	echo Initializing Polygen working environment
	export PATH=$(pwd)/tools:$PATH
	export PolyEnv="Initialized"
fi
