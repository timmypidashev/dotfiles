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

if [ $system -eq 1 ]
then 
  SYSTEM="UEFI"
fi

if [ $system -eq 2 ]
then 
  SYSTEM="LEGACY"

else
  SYSTEM="UEFI"
fi

echo $SYSTEM
