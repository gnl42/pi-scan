#!/bin/bash -e

# Pi Scan
python3 --version
pip install pip==24.3.1 --upgrade
pip --version
pip install resolvelib==1.1.0
pip install ninja==1.11.1.2
pip install patchelf==0.17.2.1
pip install numpy==1.26.4
pip install dbus-python==1.3.2
pip install six
pip install wiringpi==2.60.1
pip install kivy[full]
mkdir -p /home/pi/pi-scan
# TODO when this gets moved into pi-scan repo this should be replaced
git clone --depth 1 https://github.com/gnl42/pi-scan-tenrec /tmp/pi-scan
sudo cp -r /tmp/pi-scan/src/*                 /home/pi/pi-scan/
sudo cp -r /tmp/pi-scan/resources/spinner.gif /home/pi/pi-scan/

# For Touch Screen
mkdir -p /home/pi/.kivy

#pip install lupa --config-settings='--no-luajit'
#pip install chdkptp.py==0.1.3
# chdkptp.py
cd /home/pi
git clone --depth 1 https://github.com/5up3rD4n1/chdkptp.py
cd chdkptp.py
git submodule init
git submodule update
python setup.py install
#
chown -R pi:pi /home/pi