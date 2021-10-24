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

echo "Proceeding to install Arch Linux!"
echo $SYSTEM
