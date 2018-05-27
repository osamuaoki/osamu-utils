# Install memo
<!---
vim:se tw=78 ai si sts=4 et:
-->

This is my memo on Debian GNU/Linux system install.  This was written in 2018
based on stretch/stable and buster/testing.

## Factory reset of SSD 

If SSD is used (suppose it to be `/dev/sdx`), it is a good idea to reset it to
the factory condition using hdparm.

```
 # hal newssd /dev/sdx
```
## Install system with USB boot media

### Boot media preparation

* Download `netinst' ISO image file, e.g. `debian-9.4.0-amd64-netinst.iso`
* Plug in USB drive (> 1GB) and make it available as e.g. `/dev/sdx`.

```
 # cp debian-9.4.0-amd64-netinst.iso /dev/sdx
 # sync
```

### Install to the target HDD/SSD

* Setup BIOS (press F2 during boot to enter) to boot from USB
* Boot with USB key and target HDD/SSD
    * This can be bare metal or on virtual system (`kvm`)
* If system is intended to be upgraded to testing or unstable system, don't
  install Desktop (GUI) system and install only basic console system.  This
  extra-precaution prevents buggy dependency packages to cause upgrade
  nightmare.  
* For the primary system on the multi-boot system, install grub to the MBR
  by selecting, e.g., `/dev/sda`.
* For the secondary system on the multi-boot system, install grub to the
  partition of its root filesystem by selecting, e.g., `/dev/sda2`.
* Edit `/etc/apt/sources.list` to point to the desired distribution and do as
  follows:

```
 # vim /etc/apt/sources.list
 # apt update
 # apt dist-upgrade
 # apt install nano- vim-tiny- aptitude wget git ssh vim mc
 # apt install gdm3 task-desktop
 # shutdown -r now
  ... reboot
```

* Copy identity files

### Installation Tips

When manually building customized system or restoring system from the archive
copy, you need to pay extra attension.

* Don't share swap partition among multiple instalations.
* Don't set the file system type (such as ext4), if the installation doesn't
  mount it.
* UUID may need to be adjusted when a file system or a swap partition are
  initialized.
    * `/etc/fstab`
    * `/etc/initramfs-tools/conf.d/resume` 
* host name and its domain may need to be adjusted.
    * `/etc/hosts`
    * `/etc/hostname`
    * `/etc/exim4????`
* There are some dynamically assigned UID/GID for system users.  When copying
  system, be careful.


## Fresh install of system with HAL system

For fresh system (probably after factory reset state SSD with 
"hal newssd /dev/sdb" or similar).

* Default install *even desktopless* from boot USB key.
  (Leave some unused space ssd)
* Boot new system

If you reformat partition FS causing it to be different UUID, you need to
match UUID in /etc/fstab and /etc/initramfs-tools/conf.d/resume with the new
UUID.  UUID can be identified by `blkid`(8).

```
 $ su -c bash
 # apt install git
  ...
 # ^D
 $ mkdir ~/bin
 $ git clone git@github.com:osamuaoki/osamu-utils.git ~/bin
 $ git submodule update --init --recursive
 $ hal install0
 $ hal install1
```

### Security files

```
~/.gnupg/
~/.ssh/
```

### Manual refine

* Terminal:
    * Profile preferences
        * General -> Kill terminal bell
        * Scrolling -> No limit to scroll
    * Preferences
        * General   -> Disable Menu access by F10
        * Shortcuts -> Disable shortcut

* Packages:

```
 # aptitude -u
```


