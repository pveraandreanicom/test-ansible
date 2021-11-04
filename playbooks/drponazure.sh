#!/bin/bash

# OPERATING SYSTEMS....
#
# Linux	Only 64-bit system is supported. 32-bit system isn't supported.
#

OS=""
# Oracle Linux	6.4, 6.5, 6.6, 6.7, 6.8, 6.9, 6.10, 
#               7.0, 7.1, 7.2, 7.3, 7.4, 7.5, 7.6, 7.7, 7.8, 7.9, 
#               8.0, 8.1, 8.2, 8.3
if [ -f /etc/oracle-release ]; then
    if grep -q 'Oracle Linux Server release 6.*' /etc/oracle-release; then
        VERSION=`sed "s/[^0-9]*//g" /etc/oracle-release`
            if [ `uname -m` = "x86_64" -a $VERSION -ge 64 ]; then
            OS="OL6-64"
        fi
    elif grep -q 'Oracle Linux Server release 7.*' /etc/oracle-release; then
        if [ `uname -m` = "x86_64" ]; then
            OS="OL7-64"
        fi
    elif grep -q 'Oracle Linux Server release 8.*' /etc/oracle-release; then
        if [ `uname -m` = "x86_64" ]; then
            OS="OL8-64"
        fi
    fi
# RHEL 5.2 to 5.11
#      6.1 to 6.10
#      7.0, 7.1, 7.2, 7.3, 7.4, 7.5, 7.6, 7.7, 7.8, 7.9 Beta version, 7.9
#      8.0, 8.1, 8.2, 8.3 
elif [ -f /etc/redhat-release ]; then
    if grep -q 'Red Hat Enterprise Linux Server release 5.*' /etc/redhat-release || \
        grep -q 'CentOS release 5.*' /etc/redhat-release; then
        VERSION=`sed "s/[^0-9]*//g" /etc/redhat-release`
        if [ `uname -m` = "x86_64" -a $VERSION -ge 52 -a $VERSION -le 511 ]; then
            OS="RHEL5-64"
        fi
    elif grep -q 'Red Hat Enterprise Linux Server release 6.*' /etc/redhat-release || \
        grep -q 'Red Hat Enterprise Linux Workstation release 6.*' /etc/redhat-release || \
        grep -q 'CentOS Linux release 6.*' /etc/redhat-release ||
        grep -q 'CentOS release 6.*' /etc/redhat-release; then
        if [ `uname -m` = "x86_64" ]; then
            OS="RHEL6-64"
        fi
    elif grep -q 'Red Hat Enterprise Linux Server release 7.*' /etc/redhat-release || \
        grep -q 'Red Hat Enterprise Linux Workstation release 7.*' /etc/redhat-release || \
        grep -q 'CentOS Linux release 7.*' /etc/redhat-release; then
        if [ `uname -m` = "x86_64" ]; then
            OS="RHEL7-64"
        fi
    elif grep -q 'Red Hat Enterprise Linux release 8.*' /etc/redhat-release || \
        grep -q 'CentOS Linux release 8.*' /etc/redhat-release; then
        if [ `uname -m` = "x86_64" ]; then
            OS="RHEL8-64"
        fi
    fi
#
# SUSE Linux Enterprise Server 12 SP1, SP2, SP3, SP4, SP5 (review supported kernel versions)
# SUSE Linux Enterprise Server 15, 15 SP1 (review supported kernel versions)
# SUSE Linux Enterprise Server 11 SP3. Ensure to download latest mobility agent installer on the configuration server.
# SUSE Linux Enterprise Server 11 SP4
#
elif [ -f /etc/SuSE-release ]; then
    if grep -q 'VERSION = 11' /etc/SuSE-release && grep -q 'PATCHLEVEL = 3' /etc/SuSE-release; then
        if [ `uname -m` = "x86_64" ]; then
            OS="SLES11-SP3-64"
        fi
    elif grep -q 'VERSION = 11' /etc/SuSE-release && grep -q 'PATCHLEVEL = 4' /etc/SuSE-release; then
        if [ `uname -m` = "x86_64" ]; then
            OS="SLES11-SP4-64"
        fi
    fi
    if grep -q 'VERSION = 12' /etc/SuSE-release; then
        if [ `uname -m` = "x86_64" ]; then
            OS="SLES12-64"
        fi
    elif grep -q 'VERSION="15' /etc/SuSE-release; then
        if [ `uname -m` = "x86_64" ]; then
            OS="SLES15-64"
        fi
    fi
elif [ -f /etc/os-release ] && grep -q 'SLES' /etc/os-release; then
    if grep -q 'VERSION="15' /etc/os-release; then
        if [ `uname -m` = "x86_64" ]; then
            OS="SLES15-64"
        fi
    fi
#
# Ubuntu 14.04* LTS server (review supported kernel versions)
# Ubuntu 16.04* LTS server (review supported kernel versions)
# Ubuntu 18.04* LTS server (review supported kernel versions)
# Ubuntu 20.04* LTS server (review supported kernel versions)
#
elif [ -f /etc/lsb-release ] ; then
    if grep -q 'DISTRIB_RELEASE=14.04' /etc/lsb-release ; then
        if [ `uname -m` = "x86_64" ]; then
            OS="UBUNTU-14.04-64"
        fi
    elif grep -q 'DISTRIB_RELEASE=16.04' /etc/lsb-release ; then
        if [ `uname -m` = "x86_64" ]; then
            OS="UBUNTU-16.04-64"
        fi
    elif grep -q 'DISTRIB_RELEASE=18.04' /etc/lsb-release ; then
        if [ `uname -m` = "x86_64" ]; then
            OS="UBUNTU-18.04-64"
        fi
    elif grep -q 'DISTRIB_RELEASE=20.04' /etc/lsb-release ; then
        if [ `uname -m` = "x86_64" ]; then
            OS="UBUNTU-20.04-64"
        fi
    fi
#
# Debian 7/Debian 8 (includes support for all 7. x, 8. x versions); 
# Debian 9 (includes support for 9.1 to 9.13. Debian 9.0 is not supported.), 
# Debian 10 (Review supported kernel versions)
#
elif [ -f /etc/debian_version ]; then
    if grep -q '^7.*' /etc/debian_version; then
        if [ `uname -m` = "x86_64" ]; then
            OS="DEBIAN7-64"
        fi
    elif grep -q '^8.*' /etc/debian_version; then
        if [ `uname -m` = "x86_64" ]; then
            OS="DEBIAN8-64"
        fi
    elif grep -q '^9.*' /etc/debian_version; then
        if [ `uname -m` = "x86_64" ]; then
            OS="DEBIAN9-64"
        fi
    elif grep -q '^10.*' /etc/debian_version; then
        if [ `uname -m` = "x86_64" ]; then
            OS="DEBIAN10-64"
        fi
    fi
fi

if [ "$OS" = "" ]; then
  echo "OS not supported" 1>&2
  exit 1 
fi

# File systems	ext3, ext4, XFS, BTRFS (conditions applicable as per this table)
#
mount | grep "^/"  | grep -vEw 'ext3|ext4|xfs|brtfs' >/dev/null
if [ $? -eq 0 ]; then
  echo "FS not supported" 1>&2
  exit 1
fi

# LVM
#
# Thick provision - Yes
# Thin provision - No
NODUPLVS=""
NOSUPLVS=$(lvs --noheadings -o lv_name,lv_attr | grep V.....t... | tr -s ' ' | cut -d ' ' -f 2 | tr '\n' ' ')
if [ "$NOSUPLVS" != "" ]; then
  echo "[ $NOSUPLVS ]: volumes not supported"
fi

# - Multiple OS disks aren't supported.
#
# Let's check if root filesystem is in multiple volumes
STRIPES4ROOT=""
STRIPES4ROOT=$(lsblk -oMOUNTPOINT,PKNAME,KNAME -P | grep 'MOUNTPOINT="/"' | sort  | uniq -c | wc -l)
if [ $STRIPES4ROOT -gt 1 ]; then
  echo "Root Filesystem is in more than one dev configuration not supported" 1>&2
  exit 1
fi

# Boot directory	
# 
BOOTDISK=""
BOOTDISK=$(lsblk -oMOUNTPOINT,PKNAME -P | grep 'MOUNTPOINT="/boot"' | cut -d '"' -f 4  | sed 's/[0-9]*$//g')

# A machine without a boot disk can't be replicated.
#
if [ "$BOOTDISK" = "" ]; then
  echo "Boot fs is not present. Configuration not supported" 1>&2
  exit 1
fi
# Boot disks mustn't be in GPT partition format. 
#
for i in $BOOTDISK
do
  fdisk -l /dev/${i} | grep -i gpt
  if [ $? -eq 0 ]; then
    echo "Boot disk is gpt. Configuration not supported" 1>&2
    exit 1
  fi
done
# Multiple boot disks on a VM aren't supported
# /boot on an LVM volume across more than one disk isn't supported.
STRIPES4BOOT=""
STRIPES4BOOT=$(lsblk -oMOUNTPOINT,PKNAME,KNAME -P | grep 'MOUNTPOINT="/boot"' | sort  | uniq -c | wc -l)
if [ $STRIPES4BOOT -gt 1 ]; then
  echo "boot Filesystem is in more than one dev configuration not supported" 1>&2
  exit 1
fi

# Space
#
df -k / | awk '/^\// {if ($4 < 2097152) exit 1; }' > /dev/null
if [ $? -ne 0 ]; then
  echo "Space on / insufficient. Configuration not supported" 1>&2
  exit 1
fi

df -k /usr | awk '/^\// {if ($4 < 2097152) exit 1; }' > /dev/null
if [ $? -ne 0 ]; then
  echo "Space on /usr insufficient. Configuration not supported" 1>&2
  exit 1
fi
