#!/bin/bash

# funcions
source /usr/local/bin/utils.sh
# Preparar variables
dbsetenv

adduser --shell /bin/bash moodle
echo moodle:moodle | chpasswd -
mkdir /home/moodle/.ssh
