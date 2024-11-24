#!/bin/bash
sudo yum install ansible -y
git clone  https://github.com/nandab1805/ansible-roles-roboshop.git
cd ansible-roles-roboshop
ansible-playbook -e component=mongodb main.yaml
ansible-playbook -e component=redis main.yaml
ansible-playbook -e component=rabbitmq main.yaml
ansible-playbook -e component=mysql main.yaml
ansible-playbook -e component=catalogue main.yaml
ansible-playbook -e component=user main.yaml
ansible-playbook -e component=cart main.yaml
ansible-playbook -e component=shipping main.yaml
ansible-playbook -e component=payment main.yaml
ansible-playbook -e component=web main.yaml