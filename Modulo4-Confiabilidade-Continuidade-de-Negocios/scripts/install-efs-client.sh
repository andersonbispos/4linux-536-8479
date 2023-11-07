#!/bin/bash
sudo dnf install -y amazon-efs-utils
sudo mkdir /efs

## commands:
sudo bash -c 'echo "fs-06fb9c78c93d6de44:/ /efs efs defaults,_netdev 0 0" >> /etc/fstab'