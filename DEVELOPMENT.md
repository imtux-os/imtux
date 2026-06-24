# Development

## Dependencies:
```
# Essential dependencies:
make gcc libncurses-dev flex bison bc cpio libelf-dev libssl-dev xz-utils lbzip2 bzip2

# To emulation, install 'qemu-system-x86_64'.

# To generate the ISO file, you'll also need:
grub xorriso
```

## Get started

Clone the IMTUX repository.

Enter in the project directory:
```bash
cd imtux/
```

Download Linux Kernel and BusyBox:
```bash
./scripts/download.sh .
```

Compile Linux Kernel:
```bash
cd linux-6.19.13/
cp ../configs/kernel/.config .
make -j$(nproc) # or just pass the number of jobs you want to use (e.g., make -j8)
```

Compile BusyBox:
```bash
cd ../busybox-1.36.1/
cp ../configs/busybox/.config .
make CONFIG_PREFIX=../initramfs/ install
```

Generate the initramfs:
```bash
cd ../initramfs/
rm -rf linuxrc/
find . | cpio -o -H newc | gzip > ../initramfs.cpio.gz
```

> [!NOTE]
> At this point, you can already try running it in QEMU.

## Generate an ISO file

Put needed files in one place:
```bash
cp linux-6.19.13/arch/x86/boot/bzImage initramfs.cpio.gz iso-files/boot/
```

Generate the ISO file:
```bash
grub-mkrescue -o imtux.iso iso-files/
```

## Run in QEMU

Run without ISO:
```bash
qemu-system-x86_64 \
    -m 2G,maxmem=5G \
    -kernel linux-6.19.13/arch/x86/boot/bzImage \
    -initrd initramfs.cpio.gz \
    -append "console=ttyS0" \
    -nographic
```

Run with ISO:
```bash
qemu-system-x86_64 \
    -m 2G,maxmem=5G \
    -cdrom imtux.iso
```

If you want to exit from QEMU, try: `C-a x` or use `poweroff -f` command in the shell.

## Create a bootable USB:

> [!WARNING]
> Make sure to back up any important data from the USB drive.

```bash
sudo dd if=imtux.iso of=/dev/your_device bs=4M status=progress
```

Replace 'your_device' with the device name of your USB drive, you can use the `lsblk` command to identify it.
