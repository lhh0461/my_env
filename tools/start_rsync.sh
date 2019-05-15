#!/bin/bash

TMP_DIR="tmp"
RSYNC_PID=$TMP_DIR"/rsyncd.pid"

if [ ! -d $TMP_DIR ] ; then
    mkdir $TMP_DIR
fi

if [ -f $RSYNC_PID ] ; then
    rm $RSYNC_PID
fi

/usr/bin/rsync --daemon --config=conf/rsyncd.conf
