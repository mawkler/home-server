#!/usr/bin/env bash

if [ -z "$PASSWORD" ]; then
	echo "\$PASSWORD variable not set"
	exit 1
fi

echo "Installing docker-compose"
sudo pacman --needed -S docker docker-compose

./run.sh
