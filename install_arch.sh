#! /bin/bash

echo "Timmy's Arch Installer"

# Figure out if we are running on a Legacy or UEFI system
echo "1) UEFI System 	2) Legacy System"
read -r -p "What kind of computer are you running on? (default 1): " sys

case $sys in 
[1])
    SYSTEM="UEFI"
    ;;
[2])
    SYSTEM="LEGACY"
    ;;
[4])
    SYSTEM=""
    ;;
[*])
    SYSTEM="UEFI"
    ;;
esac

# Format disk with FDisk
echo "Formatting /dev/sda for $SYSTEM system..."

# UEFI format
if [ $sys -eq 1 ]
then
	# fdisk formatting
	(
	echo g;
	echo n;
	echo "";
	echo "";
	echo +512M;
	echo t;
	echo 1;
	echo 1;
	echo n;
	echo "";
	echo "";
	echo +25G;
	echo n;
	echo "";
	echo "";
	echo ""
	) | fdisk /dev/sda

	# actually format the partitions afterwards...
	mkfs.fat -F32 /dev/sda1
	mkfs.ext4 /dev/sda2
	mkfs.ext4 /dev/sda3

	# mount partitions
	echo "Mounting partitions..."
	mount /dev/sda2 /mnt
	mkdir /mnt/home
	mount /dev/sda3 /mnt/home
	
	echo "Disk-related stuff complete. phew..."
fi
	
# EFI format
if [ $sys -eq 2 ]
then
	echo "efi"
fi

# download linux firmware and important modules
echo "Downloading needed dependencies..."
pacstrap - /mnt base linux linux-firmware sudo nano git

# generate file-system table
genfstab -U -p /mnt >> /mnt/etc/fstab
echo "Generated file-system table..."

# chroot into system
arch-chroot /mnt /bin/bash
echo "Chrooted into system..."

# POST INSTALL PUT INTO ANOTHER SHELL SCRIPT LATER

# generate locales
sed --in-place=.bak 's/^#en_US\.UTF-8/en_US\.UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.cong
echo "Generated locales..."

# set localtime
ln -sf /usr/share/zoneinfo/America/Seattle /etc/localtime
echo "Set localtime..."

# hardware clock
hwclock --systohc --utc
echo "Configured hardware clock..."

# name and host config
read -r -p "What would you like to call this computer? " HOSTNAME
echo $HOSTNAME > /etc/hostname
sed -i "/localhost/s/$/ $HOSTNAME/" /etc/hosts #MAY BE BROKEN :(

# install networkmanager
echo "installing NetworkManager..."
sudo pacman -S --noconfirm networkmanager
systemctl enable NetworkManager

# change password | may also be broken first time writing :(
read -r -p "Set root password for $HOSTNAME: " ROOTPASSWD
echo $ROOTPASSWD | passwd
echo "Password set!"

# Bootloader installation
if [ $sys -eq 1 ] 
then
	# install grub and the boot manager
	echo "Installing boot manager..."
	pacman -S --noconfirm grub efibootmgr

	# mount bootmgr
	echo "Mounting all systems..."
	mkdir /boot/efi
	mount /dev/sda1 /boot/efi
	
	# Install grub to system
	echo "Installing and configuring grub..."
	grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable --debug
	grub-mkconfig -o /boot/grub/grub.cfg

	# complete setup
	echo "Configuration complete! Unmounting and rebooting system. Please take out your arch installation medium."
	umount -r /mnt
	exit
fi

if [ $sys -eq 2 ] 
then 
	echo "efi goes here :)"
fi








