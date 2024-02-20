#!/bin/sh
export ANSIBLE_PRIVATE_ROLE_VARS=true
ansible-playbook -i inventories/prod/hosts.yml playbook.yml -v