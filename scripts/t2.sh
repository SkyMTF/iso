#!/usr/bin/env bash

set -e -x

export DEBIAN_FRONTEND=noninteractive
export HOME=/root
export LC_ALL=C

#Getting Kernel 
wget https://github.com/AdityaGarg8/mbp-16.x-ubuntu-kernel/releases/download/v5.13.13-1/linux-headers-5.13.13-mbp-16x-wifi_5.13.13-1_amd64.deb
wget https://github.com/AdityaGarg8/mbp-16.x-ubuntu-kernel/releases/download/v5.13.13-1/linux-image-5.13.13-mbp-16x-wifi_5.13.13-1_amd64.deb
wget https://github.com/AdityaGarg8/mbp-16.x-ubuntu-kernel/releases/download/v5.13.13-1/linux-libc-dev_5.13.13-1_amd64.deb
#Install Kernel Packages in correct order
apt-get -y install /linux-headers-5.13.13-mbp-16x-wifi_5.13.13-1_amd64.deb
apt-get -y install /linux-image-5.13.13-mbp-16x-wifi_5.13.13-1_amd64.deb
apt-get -y install /linux-libc-dev_5.13.13-1_amd64.deb

#Installing Git 
apt-get -y install git 

#Installing DKMS 
wget https://raw.githubusercontent.com/SkyMTF/iso/master/dkms.conf
git clone https://github.com/t2linux/apple-bce-drv /usr/src/apple-bce-r183.c884d9c
mv dkms.conf /usr/src/apple-bce-r183.c884d9c/dkms.conf
dkms install -m apple-bce -v r183.c884d9c -k 5.13.13-mbp-16x-wifi
git clone https://github.com/t2linux/apple-ib-drv /usr/src/apple-ibridge-0.1
dkms install -m apple-ibridge -v 0.1 -k 5.13.13-mbp-16x-wifi

#making modules autoload
wget https://raw.githubusercontent.com/SkyMTF/iso/master/t2.conf
mv t2.conf /etc/modules-load.d/t2.conf

