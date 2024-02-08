#!/usr/bin/bash

PASSWORD=$1
if [ -z "$PASSWORD" ]; then
	echo 'No password argument passwed in'
	exit 1
fi

echo "Installing docker-compose and unbound"
sudo pacman --needed -S docker docker-compose unbound

echo "Setting up unbound"
sudo cp unbound/pi-hole.conf /etc/unbound/unbound.conf
sudo systemctl start unbound

echo '
name_servers="::1 127.0.0.1"
resolv_conf_options="trust-ad"
' | sudo tee /etc/resolvconf.conf
sudo resolvconf -u

mkdir -p ~/pihole
cd ~/pihole

echo "
version: '3'

# More info at https://github.com/pi-hole/docker-pi-hole/
services:
  pihole:
    container_name: pihole
    image: pihole/pihole:latest
    ports:
      - 53:53/tcp
      - 53:53/udp
      - 80:80/tcp
    environment:
      TZ: Europe/Stockholm
      WEBPASSWORD: $PASSWORD
      DNS1: 127.0.0.1#5335
      DNS2: no
    # Volumes store your data between container upgrades
    volumes:
      - ./etc-pihole:/etc/pihole
      - ./etc-dnsmasq.d:/etc/dnsmasq.d
    restart: unless-stopped
" > docker-compose.yml

echo "Running Pi-Hole container"
sudo systemctl start docker
sudo docker-compose up -d
