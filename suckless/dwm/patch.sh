#!/bin/bash
patch -p1 < patches/dwm-swallow-6.2.diff
sleep 1
patch -p1 < patches/dwm-status2d-6.2.diff
sleep 1
patch -p1 < patches/dwm-notitle-6.2.diff
sleep 1
patch -p1 < patches/dwm-noborder-6.2.diff
sleep 1
patch -p1 < patches/dwm-float-border-color-6.2.diff
sleep 1
patch -p1 < patches/dwm-cool-autostart-6.2.diff
sleep 1
patch -p1 < patches/dwm-alwayscenter-20200625-f04cac6.diff
sleep 1
patch -p1 < patches/dwm-actualfullscreen-20211013-cb3f58a.diff
