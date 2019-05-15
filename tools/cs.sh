#!/bin/bash

TAGS_PATH=".tags"
CSCOPE_FILES=$TAGS_PATH"/cscope.files"

if [ ! -d $TAGS_PATH ] ; then
    mkdir $TAGS_PATH
fi

find $(pwd) -name "*.[ch]" > $CSCOPE_FILES
echo "create cscope files success!"

cscope -bq -i $CSCOPE_FILES

mv cscope.* $TAGS_PATH

echo "create cscope database success!"
