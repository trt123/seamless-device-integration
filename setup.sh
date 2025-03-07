#!/bin/bash
echo "🚀 Starting Raspberry Pi Automation Setup..."
sudo apt update && sudo apt upgrade -y
sudo apt install syncthing samba realvnc-vnc-server kdeconnect docker alvr -y
mkdir -p /home/pi/shared && chmod 777 /home/pi/shared
echo "[Shared]\npath = /home/pi/shared\nread only = no\nbrowsable = yes\nguest ok = yes" | sudo tee -a /etc/samba/smb.conf
sudo systemctl restart smbd && systemctl enable ssh --now && systemctl enable vncserver-x11-serviced --now
sudo docker run -d --name=homeassistant --restart=unless-stopped --net=host homeassistant/home-assistant
echo "✅ Setup Complete! Rebooting..."
sudo reboot
