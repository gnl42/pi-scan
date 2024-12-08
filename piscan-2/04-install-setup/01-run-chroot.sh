#!/bin/bash -e
export PIP_ROOT_USER_ACTION=ignore
# Pi Scan

# Default pip is painfully slow
pip install pip==24.3.1 --upgrade

pip install resolvelib==1.1.0
pip install ninja==1.11.1.2
pip install patchelf==0.17.2.1
pip install numpy==1.26.4
pip install dbus-python==1.3.2
pip install six
pip install wiringpi==2.60.1
#pip install -U pysdl2
#pip install pangoft2
pip install olefile

pip install -I Cython
pip install kivy[full]==2.2.0

mkdir -p /home/pi/pi-scan


# TODO when this gets moved into pi-scan repo this should be replaced
git clone --depth 1 https://github.com/gnl42/pi-scan-tenrec /tmp/pi-scan
sudo cp -r /tmp/pi-scan/src/*                 /home/pi/pi-scan/
sudo cp -r /tmp/pi-scan/resources/spinner.gif /home/pi/pi-scan/

# For Touch Screen
mkdir -p /home/pi/.kivy
sudo cp /tmp/pi-scan/config/touch.ini /home/pi/.kivy/config.ini

cd /home/pi

#pip install lupa --install-option='--no-luajit'
# --install-option was removed from pip with 23.0.1 so do it manually
git clone --depth 1 --recursive --branch lupa-2.2 https://github.com/scoder/lupa.git
cd lupa
python3 setup.py install bdist_wheel --no-bundle --with-cython
cd ..

# libgphoto2 package isn't current so build it
git clone https://github.com/gphoto/libgphoto2.git
cd libgphoto2
autoreconf -is
./configure --libdir=/lib/arm-linux-gnueabihf
make install
make clean
cd ..

# chdkptp.py
git clone --depth 1 https://github.com/5up3rD4n1/chdkptp.py
cd chdkptp.py
git submodule init
git submodule update
python setup.py install
#

# Speed up writes to the SD card (good for ssh option)
# /boot/firmware/config.txt doesn't exist so leave it here as a reminder
#echo "dtparam=sd_overclock=100" | sudo cat >> /boot/firmware/config.txt

chown -R pi:pi /home/pi
cd /home/pi/pi-scan
gphoto2 --version || true
python3 main.py || true
