#!/bin/sh

KERNEL_FAMILY="v6.x"
KERNEL_VERSION="linux-6.19.13"
BUSYBOX_VERSION="busybox-1.36.1"

if [ $# -eq 1 ]; then
  cd $1 &&
  wget -O ${KERNEL_VERSION}.tar.xz https://cdn.kernel.org/pub/linux/kernel/${KERNEL_FAMILY}/${KERNEL_VERSION}.tar.xz &&
  tar -xf ${KERNEL_VERSION}.tar.xz &&
  wget -O ${BUSYBOX_VERSION}.tar.bz2 https://busybox.net/downloads/${BUSYBOX_VERSION}.tar.bz2 &&
  tar -xf ${BUSYBOX_VERSION}.tar.bz2
else
  echo "Usage: $0 <download_path>"
fi
