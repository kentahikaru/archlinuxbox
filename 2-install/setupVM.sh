#!/bin/sh

useradd -u 1100 -p $(openssl passwd -6 'vagrant') -U -m vagrant
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

mkdir -pm 700 /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

echo "nameserver 1.1.1.1" > /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "nameserver 86.54.11.100" >> /etc/resolv.conf
echo "nameserver 86.54.11.200" >> /etc/resolv.conf

systemctl enable sshd
systemctl start sshd

echo "=== Remove ISO from VM ==="