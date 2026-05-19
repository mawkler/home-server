#!/usr/bin/env bash

echo "Spinning up containers defined in docker-compose.yml"
sudo systemctl start docker
sudo docker-compose up -d
