# Disk Partitioning and Logical Volume Setup Guide

This guide provides step-by-step instructions to attach a 15GB disk to a virtual machine (VM), partition it into 5GB, 5GB, 3GB, and 2GB sections, and configure them as specified in the objective.

## Prerequisites

- A virtual machine (VM) running a Linux distribution (Ubuntu, CentOS, etc.).
- A 15GB unallocated disk attached to the VM.
- Root privileges or `sudo` access.

## Steps

### 1. Attach the 15GB Disk to the VM
Before proceeding, ensure that the 15GB disk is attached to your VM. You can check this by running the following command:
```
lsblk
```
- it should look like that 
![image](https://github.com/user-attachments/assets/10d62e28-86fb-4d5a-a459-9a7940f288a5)
- then you need partioning the disk
```
fdisk /dev/sda
```
use n option to create a new partion then +5G to assgin 5 GB of the disk to the partion repeat the procces for the all partions 

- format the disk 
```
mkfs.ext4 /dev/sda
```
then create the mount point 
```
mkdir /mnt/disk1
```
- mount the disk to the directory using
```
mount /dev/sda /mnt/disk1
```
- now the upcomming step is to create PV
```
pvcreate /dev/sda
```
- create VG
```
vgcreate my_vg /dev/sda
```
- Create LV with 5GB 
```
sudo lvcreate -L 5G -n my_lv my_vg

```
- create pv for /dev/sdb the one which u will use it for extenstion
```
sudo pvcreate /dev/sdb3
```
- include the vg (my_vg) to /dev/sdb3
```
sudo vgextend my_vg /dev/sdb3
```
- Extend the LV with 3GB
```
sudo lvextend -L +3G /dev/my_vg/my_lv
```
- Resize the filesystem to utilize the new space
```
sudo resize2fs /dev/my_vg/my_lv
```
 
