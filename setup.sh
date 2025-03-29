#!/usr/bin/bash

if [ -z "$PASSWORD" ]; then
	echo '$PASSWORD variable not set'
	exit 1
fi

echo "Installing docker-compose"
sudo pacman --needed -S docker docker-compose

echo "Spinning up containers defined in docker-compose.yml"
sudo systemctl start docker
sudo docker-compose up -d
