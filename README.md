# Anika Infrastructure

Scripts and config for Anika's infra.

# Project Structure

```
├── backups                 Scripts for database backups
├── bookstack               Bookstack wiki infra
└── clerk                   Clerk Django webapp infra
    ├── ansible             Ansible config
    ├── configure.sh        Run Ansible config on target webserver
    ├── encrypt-secrets.sh  Encrypt plaintext secrets using Ansible vault
    ├── README.md           Ansible-specific docs
    └── requirements.txt    Python requirements for Ansible scripts
```
