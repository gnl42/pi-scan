#!/usr/bin/env bash

# never blank the screen
xset s off -dpms

# show a splash before app starts up
feh --bg-scale splash.png

# TODO start Python app
sleep 3
while true; do
  cd /home/pi/pi-scan
  python main.py
done;
