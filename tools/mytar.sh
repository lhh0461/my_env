#!/bin/bash
PATH_NAME=$1
TAR_PATH=$(which tar)

if [ $# != 1 ] ; then
    echo "input path name error!"
    exit 1
fi

if [ -d $PATH_NAME ] ; then
    $TAR_PATH -zcvf ./mytar.tar.gz $PATH_NAME
    echo -e "\033[31m pack $PATH_NAME success!\033[0m"
    exit 0
fi

if [ -f $PATH_NAME ] ; then
    TEMP=$(echo "$PATH_NAME" | grep ".tar")
    OPT=""
    if [ ! -z $TEMP ] ; then
        OPT="xf"
        TEMP=$(echo "$PATH_NAME" | grep ".gz")
        if [ ! -z $TEMP ] ; then
            OPT=$OPT"z"
        else
            TEMP=$(echo "$PATH_NAME" | grep ".bz2")
            if [ ! -z $TEMP ] ; then
            OPT=$OPT"j"
            fi
        fi
        $TAR_PATH $OPT $PATH_NAME
        echo -e "\033[31munpack $PATH_NAME success!\033[0m"
    fi
fi
