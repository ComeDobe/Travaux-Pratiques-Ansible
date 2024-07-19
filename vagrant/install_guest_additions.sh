#!/bin/bash

# Installer les dépendances nécessaires
yum install -y epel-release
yum install -y dkms gcc gcc-c++ make bzip2 kernel-devel kernel-headers

# Télécharger et installer les Guest Additions
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
cd /tmp
wget http://download.virtualbox.org/virtualbox/${VBOX_VERSION}/VBoxGuestAdditions_${VBOX_VERSION}.iso
mount -o loop,ro VBoxGuestAdditions_${VBOX_VERSION}.iso /mnt
sh /mnt/VBoxLinuxAdditions.run || true
umount /mnt
rm -f VBoxGuestAdditions_${VBOX_VERSION}.iso

# Redémarrer les services réseau et SSH
systemctl restart network
systemctl restart sshd

# Rebooter la machine
shutdown -r now
