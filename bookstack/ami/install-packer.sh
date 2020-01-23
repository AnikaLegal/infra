#!/bin/bash
set -e
DOWNLOAD_URL=https://releases.hashicorp.com/packer/1.5.1/packer_1.5.1_linux_amd64.zip
wget $DOWNLOAD_URL -O packer.zip
rm -f packer
unzip packer.zip
rm packer.zip
