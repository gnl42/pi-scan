#!/bin/bash -e

# Pi Scan
pip install dbus-python==1.2.8
#pip install chdkptp.py
mkdir -p /home/pi/pi-scan
# TODO when this gets moved into pi-scan repo this should be replaced
git clone --depth 1 https://github.com/Tenrec-Builders/pi-scan /tmp/pi-scan
sudo cp -r /tmp/pi-scan/src/*                 /home/pi/pi-scan/
sudo cp -r /tmp/pi-scan/resources/spinner.gif /home/pi/pi-scan/

# chdkptp.py
cd /home/pi
git clone --depth 1 https://github.com/jbaiter/chdkptp.py
cd chdkptp.py
git submodule init
git submodule update
pip install .
