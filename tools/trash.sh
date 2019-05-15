#!/bin/bash

TRASH_PATH="$HOME/.trash"

if [ $# -lt 1 ] ; then
    echo "rm: 缺少参数\nTry 'rm --help' for more information."
    exit
fi

if [ $1 == "--help" -o $1 == "-h" ] ; then
    echo "rm 文件|目录"
    exit 
fi

if [ ! -d $TRASH_PATH ] ; then
    mkdir $TRASH_PATH
fi

for arg in $@ ; do
    if [ ! -f $arg -a ! -d $arg ] ; then
       echo "rm: 无法删除\"$arg\": 没有那个文件或目录" 
       continue
    fi

    COUNT=1
    BASE_NAME=`basename $arg`
    while [ -f $TRASH_PATH/$BASE_NAME -o -d $TRASH_PATH/$BASE_NAME ] ; do
        BASE_NAME=`basename $arg`"_"$COUNT
        COUNT=$(expr $COUNT + 1)
    done

    mv $arg $TRASH_PATH/$BASE_NAME
done

#启动crontab
#每周日凌晨5点清理垃圾箱
if [ -z `crontab -l|grep -o "\.trash"` ] ; then
    echo "0 5 * * 0 rm -rf $TRASH_PATH/*" > crontab_file ; crontab crontab_file
    rm crontab_file
fi

