#!/bin/sh

VM="archlinuxbox-2025.09.01"
IsoPath="/mnt/data/downloads/archlinux-2025.09.01-x86_64.iso"

vboxmanage createvm --name $VM --ostype "ArchLinux_64" --register
vboxmanage createhd --filename ~/VirtualBox\ VMs/$VM/$VM.vdi --size 40960
vboxmanage storagectl $VM --name "SATA Controller" --add sata --controller IntelAHCI
vboxmanage storageattach $VM --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium ~/VirtualBox\ VMs/$VM/$VM.vdi

vboxmanage storageattach $VM --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium $IsoPath

vboxmanage modifyvm $VM --cpus=2
vboxmanage modifyvm $VM --memory 4096
vboxmanage modifyvm $VM --vram 128
vboxmanage modifyvm $VM --graphicscontroller=vmsvga
vboxmanage setextradata $VM  "GUI/LastGuestSizeHint" "1920,1080"
vboxmanage modifyvm $VM --boot1 dvd --boot2 disk --boot3 none --boot4 none
vboxmanage modifyvm $VM --ioapic on
vboxmanage modifyvm $VM --audio-out=on
vboxmanage modifyvm $VM --clipboard-mode=bidirectional
vboxmanage modifyvm $VM --clipboard-file-transfers=enabled
vboxmanage modifyvm $VM --drag-and-drop=bidirectional

vboxmanage modifyvm $VM --nic1=nat
vboxmanage modifyvm $VM --nat-network1=nat1

vboxmanage modifyvm $VM --nic2=bridged
vboxmanage modifyvm $VM --bridge-adapter2=enp4s0


# vboxmanage showvminfo $VM
vboxmanage  getextradata $VM
vboxmanage startvm $VM