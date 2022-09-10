#!/bin/bash -e

. "${BASE_DIR}/config"

install -m 755 files/mount_unionfs "${ROOTFS_DIR}/usr/local/bin/"

on_chroot << EOF
cat <<EOT >> /etc/fstab
mount_unionfs   /etc            fuse    defaults          0       0
mount_unionfs   /var            fuse    defaults          0       0
mount_unionfs   /home           fuse    defaults          0       0
mount_unionfs   /media          fuse    defaults          0       0
EOT
EOF

install -m 644 -o 0 -g 0 files/config.txt      "${ROOTFS_DIR}/boot/"
install -m 644 -o 0 -g 0 files/55-udisks2.pkla "${ROOTFS_DIR}/etc/polkit-1/localauthority/50-local.d/"
install -m 644 -o 0 -g 0 files/99-usb.rules    "${ROOTFS_DIR}/etc/udev/rules.d/"
