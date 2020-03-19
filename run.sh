#!/usr/bin/env bash

NAME=sshd2022
RUNOPT=it
VOLOPT="-v sshd2022.etc_ssh:/etc/ssh"

docker run $RUNOPT -name $NAME -p 2022:22 r2h2/sshd $1
