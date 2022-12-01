#!/bin/bash
# usage: sudo ./install_xrdp_ubuntu.sh

sudo apt-get install -y xorg-video-abi-23
sudo apt-get install -y xrdp
sudo apt-get install -y xorgxrdp

echo "[Allow Colord all Users]" > 45-allow-colord.pkla
echo "Identity=unix-user:*" >> 45-allow-colord.pkla
echo "Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile" >> 45-allow-colord.pkla
echo "ResultAny=no" >> 45-allow-colord.pkla
echo "ResultInactive=no" >> 45-allow-colord.pkla
echo "ResultActive=yes" >> 45-allow-colord.pkla

sudo chmod 775 45-allow-colord.pkla
sudo cp 45-allow-colord.pkla /etc/polkit-1/localauthority/50-local.d/

sudo apt install ufw
sudo ufw allow 3389/tcp

sudo perl -p -i -e '$.==28 and print "\nunset DBUS_SESSION_BUS_ADDRESS\nunset XDG_RUNTIME_DIR\n"' /etc/xrdp/startwm.sh

sudo service xrdp restart

sudo apt install xfce4
