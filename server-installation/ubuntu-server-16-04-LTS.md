# Ubuntu Server 16.04 LTS Installation Guide

This is a walk-through and a standardization of the installation of the Ubuntu server 16.04 LTS for all dev and prod machines. All dev and prod Linux-based machines should use 16.04 LTS until the release of 18.04 LTS in 2018.

Unfortunately, at this stage I don't have a centralized OS deployment tool, so OS is installed manually on new hardware. Configuration after OS installation is automated by Chef in the cookbooks directory. Service development and deployment should be done in Docker.


## General Configuration

1. Plugin the Ubuntu bootable USB, enter the BIOS/UEFI, and change the USB boot priority to number 1
2. In the BIOS/UEFI, disable the SecureBoot option if it is enabled.

Options:

```
Language: English
Country: US
Keyboard: US
Hostname:
  public-facing: ystpublic<#>
  internal: ystinternal<#>
Real Name: yst
Username: yst
Password: <SECRETS>
Encrypt directory: no
Timezone: America/Toronto
```


## Disk Configuration

```
If mounted /dev/sda is detected, unmount the partition
Partitioning Method: Guided - use entire disk and set up LVM

Warning: Write change to disk will erase all existing data!

Space to use: MAX
If existing OS is installed with BIOS compatibility mode: Force UEFI installation
Write to disk? No, and review the proposed changes
  2TB /root ext4
  8.5GB swap
Finish partitioning and write changes to disk
```


## Configuration

```
HTTP Proxy: leave it blank
Updates: install security updates automatically
Software to be installed: use the default
Note: All software packages needed will be managed by Chef
```


## Reboot
Remove the USB and Reboot. Go into the BIOS/UEFI, enable the SecureBoot option. It should boot properly.

If the reboot failed with firmware error message. For example:
```
ath10k_pci ... direct firmware load failed with error 2
```

Identify the firmware that failed. If it is not critical, reboot. This happened with some newer wifi-network pci device. Otherwise, disable that pci device if this problem is intermittent.


## System Configuration
Update the system first, and then start the Chef setup
```
sudo apt-get update && sudo apt-get upgrade

```
