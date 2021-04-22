#!/bin/bash
set -e
cp ./ansible/secrets.yml ./ansible/secrets.secret.yml
ansible-vault decrypt ./ansible/secrets.secret.yml --vault-password-file ~/.vault-pass.txt
