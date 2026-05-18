#!/bin/sh

KERNEL_FAMILY="v6.x"
KERNEL_VERSION="linux-6.19.13"
BUSYBOX_VERSION="busybox-1.36.1"

wget https://cdn.kernel.org/pub/linux/kernel/${KERNEL_FAMILY}/${KERNEL_VERSION}.tar.xz
tar -xf ${KERNEL_VERSION}.tar.xz

wget https://busybox.net/downloads/${BUSYBOX_VERSION}.tar.bz2
tar -xf ${BUSYBOX_VERSION}.tar.bz2
