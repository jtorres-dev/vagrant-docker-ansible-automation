FROM ubuntu:20.04

RUN apt update && \
apt install vim ansible -y && \
ansible-galaxy collection install community.crypto

COPY . /ansible

ENTRYPOINT ansible/entry_point.sh 192.168.56.102 192.168.56.103 192.168.56.104
