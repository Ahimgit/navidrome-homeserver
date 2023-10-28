@set wsl_path=%CD:\=/%
@set wsl_path=/mnt/%wsl_path:~0,1%/%wsl_path:~3%
wsl -d Ubuntu-22.04 /bin/bash -c "cd %wsl_path%/ansible && ansible-playbook -i inventories/prod/hosts.yml playbook.yml -v"
pause