#!/bin/sh

ansible-playbook -i inventories/prod/hosts.yml playbook.yml -v