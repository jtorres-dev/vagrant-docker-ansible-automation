#!/bin/bash

echo 'Updating'
apt update &>/dev/null
echo 'Upgrading'
apt upgrade -y &>/dev/null
echo 'Installing dependencies and tools'
apt install git vim curl network-manager net-tools bind9 bind9utils nfs-common nfs-kernel-server -y &>/dev/null

# Changed priviledges to allow Vagrant to rewrite
# sshd config file
chmod 777 /etc/ssh && chmod 666 /etc/ssh/sshd_config
