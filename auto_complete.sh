#! /bin/bash

SOURCES_FILE="sources.txt"

function setScriptDir {
    if [[ x"${MARS_SCRIPT_DIR}" == "x" ]]; then
        MARS_SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
    fi
    export MARS_SCRIPT_DIR=${MARS_SCRIPT_DIR}
}

setScriptDir

function parse_yaml {
   local s='[[:space:]]*' w='[a-zA-Z0-9_-]*' fs=$(echo @|tr @ '\034')
   sed -ne "/.:./d" \
        -e "/#/d" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\2|p" $1
}

packages1="bootstrap install rebuild clean"
packages=""
while read source_file; do
    source_file=${source_file/\#*/}
    if [[ x${source_file} = x ]]; then
        continue
    fi
    p=$(parse_yaml "${MARS_SCRIPT_DIR}/${source_file}")
    IFS='
'
    set -f
    for line in ${p}; do
	if [[ x${packages} != x ]]; then
	    packages+=" "
	fi
	packages+=${line}
    done
    set +f
    unset IFS
done < ${MARS_SCRIPT_DIR}/${SOURCES_FILE}

#echo "packages: ${packages1} ${packages}"

complete -o default -W "${packages1} ${packages}" mars.sh
complete -o default -W "${packages}" mars_install
complete -o default -W "${packages}" mars_bootstrap
complete -o default -W "${packages}" mars_rebuild
