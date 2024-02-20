@echo off
setlocal enabledelayedexpansion

set "wsl_full_path=%CD:\=/%"
set "wsl_drive=%wsl_full_path:~0,1%"
set "wsl_drive=!wsl_drive:C=c!"
set "wsl_drive=!wsl_drive:D=d!"
set "wsl_drive=!wsl_drive:E=e!"
set "wsl_full_path=%wsl_drive%%wsl_full_path:~2%"
wsl -d Ubuntu-22.04 /bin/bash -c "cd /mnt/%wsl_full_path%/ansible && export ANSIBLE_PRIVATE_ROLE_VARS=true && ansible-playbook -v -i inventories/prod/hosts.yml playbook.yml"
pause