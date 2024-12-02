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
