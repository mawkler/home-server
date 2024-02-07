#!/usr/bin/bash

PASSWORD=$1
if [ -z "$PASSWORD" ]; then
	echo 'No password argument passwed in'
	exit 1
fi

echo "Installing docker-compose"
sudo pacman --needed -S docker docker-compose

mkdir -p ~/pihole
cd ~/pihole

echo "
version: '3'

services:
  pihole:
    container_name: pihole
    image: pihole/pihole:latest
    network_mode: host # Because DHCP
    environment:
      TZ: America/Chicago
      WEBPASSWORD: $PASSWORD
    volumes:
      - ./etc-pihole:/etc/pihole
      - ./etc-dnsmasq.d:/etc/dnsmasq.d
    cap_add:
      - NET_ADMIN
    restart: unless-stopped
" > docker-compose.yml

echo "Running Pi-Hole container"
sudo systemctl start docker
sudo docker-compose up -d
