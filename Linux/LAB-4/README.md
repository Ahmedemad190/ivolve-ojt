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
 - to make a presetint mount
1. print the uuid and the mount points
```
lsblk --fs
```
copy the required info and edit /etc/fstab it should look like that 

```
 /etc/fstab: static file system information
#
# Use 'blkid' to print the universally unique identifier for a device;
# this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system>                         <mount point>   <type>  <options>               <dump>  <pass>

# Root filesystem
UUID=05e5f40e-9aaf-4dbb-a7c4-d2092150d207 /               ext4    errors=remount-ro       0       1

# Boot EFI partition
UUID=73AE-9FB0                          /boot/efi       vfat    umask=0077,nofail        0       1

# Swap file
/swapfile                               none            swap    sw,nofail                0       0

# Additional ext4 partitions
UUID=f3a8cfbd-12ae-4050-a5f9-c406fc8d347c /mnt/lvm      ext4    defaults,nofail          0       0
UUID=ffaae7d7-b433-4235-938e-88e35b2a2cd9 /data         ext4    defaults,nofail          0       0
```
> [!IMPORTANT]
> the nofail option is if u made a mistake during the confugrtion the system will boot regredless the error
- test the confgurtion with
```
sudo mount -a
```


