#!/bin/bash

vm1_ip=$1
vm2_ip=$2
vm3_ip=$3

# Setting up Ansible Inventory
echo -e "[ns]\n$vm1_ip:4452" >> /etc/ansible/hosts
echo -e "\n[nfs]\n$vm1_ip:4452" >> /etc/ansible/hosts
echo -e "\n[vm1]\n$vm1_ip:4452" >> /etc/ansible/hosts
echo -e "\n[vm2]\n$vm2_ip" >> /etc/ansible/hosts
echo -e "\n[vm3]\n$vm3_ip\n" >> /etc/ansible/hosts

# Producing ssh key and appending to authorized_keys
mkdir ~/.ssh
ssh-keygen -N "" -f ~/.ssh/id_rsa

# allows ssh connection to vm2 and vm3
ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@$vm1_ip -p 4452
ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@$vm2_ip
ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@$vm3_ip

# start the master playbook
ansible-playbook -K ansible/main.yml
