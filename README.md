# Anika Infrastructure

Scripts and config for Anika's infra.

# Project Structure

```
├── wiki                        Wiki infra
├── bookstack                   Bookstack wiki infra
└── clerk                       Clerk Django webapp infra
    ├── configure               Ansible configuration for Clerk webserver
    │   ├── ansible             Ansible config
    │   ├── configure.sh        Run Ansible config on target webserver
    │   ├── encrypt-secrets.sh  Encrypt plaintext secrets using Ansible vault
    │   ├── README.md           Ansible-specific docs
    │   └── requirements.txt    Python requirements for Ansible scripts
    └── scripts
        └── backup-database.sh  Back up Clerk database to S3
```
