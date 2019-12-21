#!/bin/bash
set -e
DOWNLOAD_URL=https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip
wget $DOWNLOAD_URL -O terraform.zip
rm -f terraform
unzip terraform.zip
rm terraform.zip
rm -f ./scripts/terraform/terraform
mv terraform ./scripts/terraform
