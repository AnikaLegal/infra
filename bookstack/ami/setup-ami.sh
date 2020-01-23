#!/bin/bash
# Install BookStack app on Ubuntu 18.04
# Called by Packer to produce an AWS AMI
# https://www.bookstackapp.com/docs/admin/installation/#ubuntu-1804
set -e

# Handle some magical apt sources race condition bullshit.
echo "Waiting up to 180 seconds for cloud-init to update /etc/apt/sources.list"
timeout 180 /bin/bash -c 'until stat /var/lib/cloud/instance/boot-finished 2>/dev/null; do echo waiting ...; sleep 1; done'

# Add SSH keys
MS_DESKTOP_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCfXP53x8aMWUjml94SKFZTGP6IlRPakuYve0QPPWhR4e+UzWhBefNS5hl1eDLkfv4QhIx1ELelZgpHeqnOBNl2P79+p5Z/TFu5U66BbrRayVy2g7/mc5USfZw3D4jxRy+r7FVzUcdGs+S2yW1TW0PxMdzRrTvHXYAIq5ILgr4MBuzkhL4DTBXb4zD5Dlkeypeivi2gbrEA4LRnhas2xZULDVXPN7m/U4eVofHPERMTl23wX9iteYaIknoThS8pwyi2vGRj63bePV2l2GMw9KaG3IxoKLBqQkRori1u4WcZuuiMlgrEUfpqoZUBIon6LhsXAB4IzzaQwt7t+DLrFTckSLw6SNCkuXNuJmAPjeh4rsONies9NNZ72g++1ec4Yrh7SQK1GH/5EHU7g2qzR2Ygb0JkUmgwuvpc2L3mLg8daNV5mFaALcu03WiccnFkYu3qEcnIB+4YTNgHIClTJOaHENix3QJvyuFsESNE2nZUNDctKMNlVs/PD1Bq6sEeIqucZ4ONVzw1hXa2BLfym21nxRsccBLmQilVXsJfAnkd5+LkggfN8Mn0eYFM3M8w29HBcoZn2Gu6fdKD2hPjz+zDhzIik3HRidldZizUU0wj4uSEsBgZmd2vbI6+1ADJgAIAWZSqb093l7Qj1wtHUE3gaOhT8Nr8KkjxokMBKh2I7w== mattdsegal@gmail.com"
echo $MS_DESKTOP_KEY >> /home/ubuntu/.ssh/authorized_keys

echo "Installed SSH keys:"
cat /home/ubuntu/.ssh/authorized_keys

# Download and run the BookStackApp setup script
DOMAIN="wiki.anikalegal.com"
SCRIPT_URL=https://raw.githubusercontent.com/BookStackApp/devops/master/scripts/installation-ubuntu-18.04.sh
wget $SCRIPT_URL
chmod a+x installation-ubuntu-18.04.sh
sudo ./installation-ubuntu-18.04.sh $DOMAIN
