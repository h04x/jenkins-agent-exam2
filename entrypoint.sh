#!/bin/bash

# add jenkins to docker.sock group,
# if group not exists create it
sock=/var/run/docker.sock

if test -e "$sock"; then
    gid=$(ls -n $sock | awk '{print $4}')
    groupadd --gid $gid dockertwo
    usermod -aG $gid jenkins
fi

/usr/sbin/sshd -D