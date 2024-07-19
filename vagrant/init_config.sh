#!/bin/bash

# Configuration DNS
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
sudo systemctl restart network

# Configuration des dépôts CentOS
sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Désactivation d'IPv6
echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Nettoyage et mise à jour
sudo yum clean all
sudo yum update -y 
