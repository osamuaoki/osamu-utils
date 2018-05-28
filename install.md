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

### Boot and account USB key preparation

* Download `netinst' ISO image file, e.g. `debian-9.4.0-amd64-netinst.iso`
* Plug in USB drive (> 1GB) and make it available as e.g. `/dev/sdx`.

```
 # cp debian-9.4.0-amd64-netinst.iso /dev/sdx
 # sync
```

Please also have your account-USB key which contains basic account settings
and secure its content using LUKS and filesystem encryption.  The data in
backup/home_data directory of your account-USB key includes:

* `~/.getmail/`
* `~/.gnupg/`
* `~/.ssh/`
* `~/bin/`
* `~/.mailfilter`
* `~/.msmtprc`
* `~/.muttrc`

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
 # apt install nano- vim-tiny- aptitude wget git ssh vim mc git
 # apt install gdm3 task-desktop
 # shutdown -r now
```

* login to your primary user account on GNOME Desktop
* insert your account-USB key
* Copy files from backup/home_data directory in your account-USB key to the
  home directory of your primary user account.  Now you have `~/bin`,
  `~/.ssh`, and `~/gnupg`.
* Use `~/bin/hal to set up system.

```
 $ cd ~/bin
 $ ./hal update
 $ ./hal dotfiles
 $ ./hal install0
 $ ./hal install1
```

* Unplug your account-USB key
* reboot the system with full GUI tools.
* Insert your account-USB key to set up GNOME keyring

```
 $ GPG/bin/setup
```

### Installation Tips

When manually building customized system or restoring system from the archive
copy, you need to pay extra attention.

* Don't share swap partition among multiple installations.
* Don't set the file system type (such as ext4), if the installation doesn't
  mount it.
* UUID may need to be adjusted when a file system is reformatted with `mkfs` a
  swap partition are reinitialized with `mkswap`.  UUID can be identified
  by `blkid`(8).
    * `/etc/fstab`
    * `/etc/initramfs-tools/conf.d/resume` 
* host name and its domain may need to be adjusted.
    * `/etc/hosts`
    * `/etc/hostname`
    * `/etc/exim4????`
* There are some dynamically assigned UID/GID for system users.  When copying
  system, be careful.
* Ethernet interface name may be different.
    * `ifupdown` via `/etc/network/interfaces`:
        * virtual boot (qemu) may be named like: ens3
        * new normal boot may be named like: enp0s25
        * older normal boot may be named like: eth0
    * Ethernet interface to be controlled by `network-manager`
        * comment out hotplug devices in `/etc/network/interfaces`

## sudo

```
 # addgroup <username> sudo
```

Alternatively

```
# cat >/etc/sudoers.d/<username> <<EOF
<username>  ALL=(ALL) NOPASSWD:ALL
EOF
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

## EXT4 optimize ideas for note PC

* `sudo tune2fs -o journal_data_writeback /dev/sda2` from other boot media.
* `/etc/fstab option field`:
 	* `noatime,discard,data=writeback,barrier=0,commit=60,errors=remount-ro`

## GRUB

* `grub-theme-starfield`
* `grub2-splashimages`

```
 echo 'GRUB_BACKGROUND="/usr/share/images/grub/Lake_mapourika_NZ.tga"' \
   >> /etc/default/grub
 sudo update-grub
```

## Evolution

Connect to gmail with IMAP/SSL and SMTP/STARTTLS
(Mutt works as backup system if connected with POP3)

## Japanese

* Font: vlgothic, ipa*
* IM: ibus-anthy
    * add `libqt5gui5`
* configure Keybinding to be like Mac
    * latin_mode: Muhenkan
    * hiragana_mode: henkan

