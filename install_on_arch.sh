#!/bin/env bash
set -e

# wallset deps: ffmpeg, feh, imagemagick, xorg-xrandr, xdg-utils, sed

echo "Welcome!" && sleep 2

#Default variables
HELPER="paru"

# does full system update
echo "Doing a system update, cause stuff may break if it's not the latest version..."
sudo pacman --noconfirm -Syu

# installs base-devel
echo "Installing base-devel in case it's not installed..."
sudo pacman -S --noconfirm --needed base-devel wget git

# choose video driver
echo "1) xf86-video-intel 	2) xf86-video-amdgpu 3) nvidia 4) Skip"
read -r -p "Choose you video card driver(default 1)(will not re-install): " vid

case $vid in 
[1])
      DRI='xf86-video-intel'
      ;;

[2])
      DRI='xf86-video-amdgpu'
      ;;

[3])
      DRI='nvidia nvidia-settings nvidia-utils'
      ;;

[4])
      DRI=""
      ;;
  
[*])
      DRI='xf86-video-intel'
      ;;
esac

# installs xorg
echo "Installing xorg display server and graphics driver..."
sudo pacman -S --noconfirm --needed xorg $DRI 

# install AUR helper
echo "We need an AUR helper. It is essential. 1) paru       2) yay"
read -r -p "What is the AUR helper of your choice? (Default is paru): " num

if [ $num -eq 2 ]
then
    HELPER="yay"
fi

if ! command -v $HELPER &> /dev/null
then
    echo "It seems that you don't have $HELPER installed, I'll install that for you before continuing."
	git clone https://aur.archlinux.org/$HELPER.git ~/.srcs/$HELPER
	(cd ~/.srcs/$HELPER/ && makepkg -si )
fi

# installs xmonad
echo "Installing xmonad..."
sudo pacman -S --noconfirm --needed xmonad xmonad-contrib

# install dotfiles into home dir
# ---
# install xmonad config
mkdir ~/.xmonad
cp .xmonad/xmonad.hs ~/.xmonad/xmonad.hs

# copy .xinitrc and .bashrc configs
cp .xinitrc ~/.xinitrc
cp .bashrc ~/.bashrc

# create .wallpaper dir in case repo gets removed, etc and for wallset stuff to work
mkdir ~/.wallpapers
cp wallpapers/nature/forest_hills.jpg ~/.wallpapers/forest_hills.jpg

# installs wallset and neccessary deps
echo "Installing wallset..."
sudo pacman -S --noconfirm --needed ffmpeg feh imagemagick xorg-xrandr xdg-utils sed
git clone https://github.com/timmypidashev/wallset down-wallset
cd down-wallset 
./install.sh

cd .. && rm -rf down-wallset






