#!/bin/bash

if [ -z "$1" ] ; then
    echo $0 username \"ssh_key_desc\"
    exit
fi

USER=$1

if [ -d "/home/$USER" ] ; then
    echo "user exists "
    exit
fi

useradd $USER && mkdir "/home/$1/.ssh" && chown $USER:$USER "/home/$1/.ssh" && chmod 700 "/home/$1/.ssh"

KEY="$2"
cat "$2" > /home/$1/.ssh/authorized_keys
chown $USER:$USER /home/$1/.ssh/authorized_keys
chmod 600 /home/$1/.ssh/authorized_keys
ls -l /home/$1/.ssh
ls -l /home/$1/.ssh/authorized_keys
