#!/bin/bash

./cleanup-lab.sh

for i in {01..20}
do
    sudo useradd  -p $(openssl passwd -1 raspberry) dev$i -G i2c,users,docker -m
    echo "dev$i ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/010_pi-nopasswd
    echo "export LAB_PORT=$(shuf -i 49152-65535 -n 1)" | sudo tee -a /home/dev$i/.bashrc
    echo 'export LAB_HOST=$(hostname -I | cut -d" " -f 1)' | sudo tee -a /home/dev$i/.bashrc
done