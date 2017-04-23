# Ubuntu Server 16.04 LTS Installation Guide

This is a walk-through and a standardization of the installation of the Ubuntu server 16.04 LTS for all dev and prod machines. All dev and prod Linux-based machines should use 16.04 LTS until the release of 18.04 LTS in 2018.

Unfortunately, at this stage I don't have a centralized OS deployment tool, so OS is installed manually on new hardware. Configuration after OS installation is automated by Chef in the cookbooks directory. Service development and deployment should be done in Docker.


## OS Install Configuration

1. Plugin the Ubuntu bootable USB, enter the BIOS/UEFI, and change the USB boot priority to number 1
2. In the BIOS/UEFI, disable the SecureBoot option if it is enabled.

Options:

```
Language: English
Country: US
Keyboard: US
Hostname:
  public-facing: <hostname>public<#>
  internal: <hostname>internal<#>
Real Name: <USERNAME>
Username: <USERNAME>
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

Identify the firmware that failed. If it is not critical, reboot. This happened with some newer wifi-network pci devices. Otherwise, disable that pci device if this problem is intermittent.


## System Configuration
Update the system first
```
sudo apt-get update && sudo apt-get upgrade
```

Start the Chef setup. Follow the README of this repo: https://github.com/tony-yang/baremetal-init

Create a RSA key-pair: `ssh-keygen`

Connect to the new machine from the local box where the RSA key-pair was generated, and create an authorized_keys file
```
mkdir ~/.ssh
chmod 700 ~/.ssh
cd .ssh
touch authorized_keys
chmod 600 authorized_keys
```
Copy the public key into the authorized_keys file. Test it to make sure SSH using the RSA key-pair works.

Disable Password Authentication (Usually `PasswordAuthentication yes` is commented out)
```
sudo vim /etc/ssh/sshd_config
PasswordAuthentication no

# Also ensure the following
PubkeyAuthentication yes
ChallengeResponseAuthentication no
```

Configure a static NAT IP instead of using DHCP
```
sudo vim /etc/network/interfaces

# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
#auto enp4s0
#iface enp4s0 inet dhcp
auto enp4s0    #### NOTE: the interface might be different, change accordingly
iface enp4s0 inet static
address 192.168.2.<ADDRESS>
netmask 255.255.255.0
network 192.168.2.0
broadcast 192.168.2.255
gateway 192.168.2.1
dns-nameservers 192.168.2.1
```

Reboot `sudo reboot` && Profit!
