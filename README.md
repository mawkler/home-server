# Home Server

This is my home server.

## Installation

Run `PASSWORD=<password> setup.sh`, with a password of your choice.

### To auto-run on system boot

```sh
mkdir -p ~/.config/systemd/user
ln -s ~/home-server/home-server.service ~/.config/systemd/user/home-server.service
```

## Running manually

Run `./run.sh`.

## Pi-hole admin page URL

Admin page should be at http://localhost/admin
