#! /bin/bash

PUSH=false

for i in $*; do 
    if [ "$i" = "+w" ]; then
        PUSH=true
    fi
    LAST=$i
done

PACKAGE_FILE="packageList.txt"

pushd . > /dev/null 2>&1

function setScriptDir {
    if [[ x"${MARS_SCRIPT_DIR}" == "x" ]]; then
        MARS_SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
    fi
    export MARS_SCRIPT_DIR=${MARS_SCRIPT_DIR}
}

setScriptDir
source ${MARS_SCRIPT_DIR}/func_collection.sh

if [[ $# == 0 ]]; then
    printErr "Please specify an action. Your options are:
       bootstrap, fetch, update, install, rebuild, clean, diff, or uninstall"
    popd > /dev/null 2>&1
    exit 1
fi

setupConfig || exit 1

SOURCES_FILE="sources.txt"
while read source_file; do
    source_file=${source_file/\#*/}
    if [[ x${source_file} = x ]]; then
        continue
    fi
    eval $(parse_yaml "${MARS_SCRIPT_DIR}/${source_file}" "")
done < ${MARS_SCRIPT_DIR}/${SOURCES_FILE}


if [[ -f ${MARS_SCRIPT_DIR}/${LAST} ]]; then
    PACKAGE_FILE=$LAST
else
    last_clean=${LAST//-/_}
    p="${last_clean}_path"
    if [[ x${!p} != x ]]; then
        PACKAGE_FILE=$LAST
    fi
fi


for arg in $*; do
    case ${arg} in
        bootstrap)
            forAllPackagesDo fetch || exit 1
            forAllPackagesDo patch || exit 1
            setup_env || exit 1
            forAllPackagesDo install || exit 1
            ;;
        fetch)
            forAllPackagesDo fetch || exit 1
            forAllPackagesDo patch || exit 1
            ;;
        update)
            forAllPackagesDo update || exit 1
            ;;
        install)
            setup_env || exit 1
            forAllPackagesDo patch || exit 1
            forAllPackagesDo install || exit 1
            ;;
        clean)
            forAllPackagesDo clean || exit 1
            ;;
        rebuild)
            forAllPackagesDo clean || exit 1
            setup_env || exit 1
            forAllPackagesDo install || exit 1
            ;;
        diff)
            forAllPackagesDo diff || exit 1
            ;;
        uninstall)
            forAllPackagesDo uninstall || exit 1
            ;;
        +w)
            ;;
        *)
            if ! [ "${arg}" = "${PACKAGE_FILE}" ]; then
                printErr "unsupported argument \"${arg}\"."
            fi
            ;;
    esac
done

popd > /dev/null 2>&1
