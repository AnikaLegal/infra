#!/bin/bash
set -e
if [[ -z "$1" ]]
then
    echo "Hostname argument not set, exiting"
    exit 1
fi
HOST=$1

if [[ -z "$2" ]]
then
    echo "App name argument not set, exiting"
    exit 1
fi
APP_NAME=$2

echo ">>> Setting up server"
ssh ubuntu@${HOST} /bin/bash << EOF
    echo ">>> Creating backup dir"
    sudo mkdir -p /srv/backups
    sudo chown -R ubuntu:ubuntu /srv/backups
    if [ ! -d /srv/backups/env ]
    then
        echo ">>> Creating virtualenv"
        pip3 install virtualenv
        python3 -m virtualenv -p python3 /srv/backups/env
    fi
EOF
echo ">>> Copying files"
scp  ./server/* ubuntu@${HOST}:/srv/backups/
SCRIPT_NAME=backup-$APP_NAME.sh
scp ../scripts/$APP_NAME/backup-server.sh ubuntu@${HOST}:/srv/backups/$SCRIPT_NAME

echo ">>> Installing requirements"
ssh ubuntu@${HOST} /bin/bash << EOF
    . /srv/backups/env/bin/activate
    pip3 install -r /srv/backups/requirements.txt
    echo ">>> Setting up cron job"
    python3 /srv/backups/cron.py add /srv/backups/$SCRIPT_NAME
    python3 /srv/backups/cron.py view
EOF
echo ">>> Setup finished"
