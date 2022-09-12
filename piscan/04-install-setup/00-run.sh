#!/bin/bash -e

. "${BASE_DIR}/config"

install -m 755 files/mount_unionfs "${ROOTFS_DIR}/usr/local/bin/"

on_chroot << EOF
# Enable auto-login
# https://github.com/RPi-Distro/raspi-config/blob/cd86846921953b39faf7cf48bb9dd187240094e5/raspi-config#L1403
#systemctl --quiet set-default multi-user.target

#cat <<EOT >> /etc/fstab
#mount_unionfs   /etc            fuse    defaults          0       0
#mount_unionfs   /var            fuse    defaults          0       0
#mount_unionfs   /home           fuse    defaults          0       0
#mount_unionfs   /media          fuse    defaults          0       0
#EOT

cat <<EOT >> /home/${FIRST_USER_NAME:='pi'}/.profile

# first-run script
[[ -f ./firstrun.sh ]] && ./firstrun.sh

# silent startx on video console

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  startx > /dev/null 2>&1
  exit
fi
EOT
EOF

HOME="${ROOTFS_DIR}/home/${FIRST_USER_NAME:='pi'}"
install -m 644 -o 0 -g 0       files/config.txt      "${ROOTFS_DIR}/boot/"
install -m 644 -o 0 -g 0       files/55-udisks2.pkla "${ROOTFS_DIR}/etc/polkit-1/localauthority/50-local.d/"
install -m 644 -o 0 -g 0       files/99-usb.rules    "${ROOTFS_DIR}/etc/udev/rules.d/"
#install -m 644 -o 0 -g 0       files/autologin.conf  "${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/"
install -m 755 -o 1000 -g 1000 files/firstrun.sh     "${HOME}/"
