#!/bin/bash
LFS=/mnt/lfs
LFS_TGT=$(uname -m)-lfs-linux-gnu
MAKEFLAGS=-j$(nproc)
lsblk -f
read -r -p "which disk do you want to install BJL on? (example /dev/sda) " disk
fdisk $disk
read -r -p "boot partition? (example /dev/sda1) " boot
read -r -p "swap? (example /dev/sda2) " swap
read -r -p "root partition? (example /dev/sda3) " root

# Format partitions
mkfs.fat -F32 $boot
mkswap $swap
mkfs.ext4 $root

# Display partition information
parted $disk print
mount $root /mnt/lfs
swapon $swap
mkdir $LFS/BJLtempins
cp -r ./* $LFS/BJLtempins
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources
wget https://mirrors.ustc.edu.cn/lfs/lfs-packages/lfs-packages-12.0.tar --continue --directory-prefix=$LFS/sources
cd $LFS/sources
# Check if system is BIOS or UEFI
# Generated by ChatGPT
if [ -d "/sys/firmware/efi" ]; then
    echo "uefi"
    wget https://ftp.gnu.org/gnu/grub/grub-2.06.tar.xz
    wget https://www.linuxfromscratch.org/patches/blfs/12.0/grub-2.06-upstream_fixes-1.patch
    wget https://unifoundry.com/pub/unifont/unifont-15.0.06/font-builds/unifont-15.0.06.pcf.gz
    wget https://github.com/rhboot/efibootmgr/archive/18/efibootmgr-18.tar.gz
    wget https://github.com/rhboot/efivar/releases/download/38/efivar-38.tar.bz2
    wget https://mandoc.bsd.lv/snapshots/mandoc-1.14.6.tar.gz
    wget http://ftp.rpm.org/popt/releases/popt-1.x/popt-1.19.tar.gz
    wget https://ftp.gnu.org/gnu/which/which-2.21.tar.gz
    wget https://downloads.sourceforge.net/libpng/libpng-1.6.40.tar.xz
    wget https://downloads.sourceforge.net/freetype/freetype-2.13.1.tar.xz
    wget https://github.com/harfbuzz/harfbuzz/releases/download/8.1.1/harfbuzz-8.1.1.tar.xz
    wget https://github.com/unicode-org/icu/releases/download/release-73-2/icu4c-73_2-src.tgz
else
    echo "bios"
fi

wget https://ftp.gnu.org/gnu/libtasn1/libtasn1-4.19.0.tar.gz
wget https://github.com/p11-glue/p11-kit/releases/download/0.25.0/p11-kit-0.25.0.tar.xz
wget https://github.com/lfs-book/make-ca/releases/download/v1.12/make-ca-1.12.tar.xz
wget https://ftp.gnu.org/gnu/wget/wget-1.21.4.tar.gz
tar -xf lfs-packages-12.0.tar
cp 12.0/* .
sh $LFS/BJLtempins/arch
