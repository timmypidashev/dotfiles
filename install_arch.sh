#! /bin/bash

echo "Timmy's Arch Installer"

# Make sure we are connected to the internet
read -p "Are you connected to internet? [y/N]: " connection
if ! [ $connection = "y" ] && ! [ $connection = "Y" ]
then 
    echo "Connect to internet to continue..."
    exit
fi


# Figure out if we are running on a Legacy or UEFI system
echo "1) UEFI System 	2) Legacy System"
read -r -p "What kind of computer are you running on? (default 1): " system

case $system in 
[1])
    SYSTEM="UEFI"
    ;;
[2])
    SYSTEM="LEGACY"
    ;;
[*])
    SYSTEM="UEFI"
    ;;
esac

echo "Proceeding to install Arch Linux!"

