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
and secures its content using LUKS and filesystem encryption.

The backup/home_data directory of your account-USB key holds basic set ups:

* `~/bin/`
* `~/.getmail/`
* `~/.gnupg/`
* `~/.ssh/`
* `~/.bash_aliases`
* `~/.bashrc`
* `~/.bashrc_local`
* `~/.mailfilter`
* `~/.msmtprc`
* `~/.muttrc`
* `~/.profile`
* `~/.vimrc`

### Install to the target HDD/SSD

* Setup BIOS (press F2 during boot to enter) to boot from USB
* Boot with USB key and target HDD/SSD
    * This can be bare metal or on virtual system (`kvm`)
* If system is intended to be upgraded to testing or unstable system, don't
  install Desktop (GUI) system and install only basic console system.  This
  extra-precaution prevents buggy dependency packages to cause upgrade
  nightmare when installing `testing/unstable` system from `stable` boot
  CD/USB.
* For the primary system on the multi-boot system, install grub to the MBR
  by selecting, e.g., `/dev/sda`.
* For the secondary system on the multi-boot system, install grub to the
  partition of its root filesystem by selecting, e.g., `/dev/sda2`.
* Login to non-X console as the primary user.
    * If you wish to install the `stable` system, you skip this step.
    * If you wish to install the `testing/unstable` system instead using the
      `stable` boot CD/USB, edit `/etc/apt/sources.list` to point to the
      desired distribution, e.g., `stretch` --> `buster`:
```
 $ su --preserve-environment -l
 # sed -i -e 's/stretch/buster/g' /etc/apt/sources.list
 # ^D
```
* Proceed to the initial setup (install `git` and `sudo`)
```
 $ su --preserve-environment -l
 # apt install sudo git equivs
 # ^D
 $ git clone https://github.com/osamuaoki/osamu-utils.git bin
 $ hal dotfiles
 $ hal initial-setup
 ... reboot system
```
* Login to non-X console as the primary user.
```
 $ hal install gui
 $ sudo shoutdown -r now
 ... reboot system
```
If full packages including TeX and non-free documentation packages are
required, use `hal install tex`.
* Login to Gnome Desktop and console terminal to your primary user account.
* Set-up gnome-terminal preferences
    * Profile preferences
        * General -> Kill terminal bell
        * Scrolling -> No limit to scroll
    * Preferences
        * General   -> Disable Menu access by F10
        * Shortcuts -> Disable shortcut (F1 etc.)
* Set-up mc preferences
    * Always pause after shell execution for `mc`
* Insert your account-USB key (Decrypt disk with LUKS keyphrase) and mount it.
* Copy files from `/media/<uswername>/GPG/backup/` directory of your
  account-USB key to the home directory of your primary user account.
* Update `bin/.git/config` to have:
```
...
[remote "origin"]
    url = git@github.com:osamuaoki/osamu-utils.git
...
```
* Update `~/bin` with submodules:
```
 $ hal update
```
* Insert your account-USB key again to set up GNOME keyring for `msmtp-gnome`

```
 $ /media/<uswername>/GPG/setup/setup
```

TIP: If you have permission issue, execute `su --preserve-environment -l` to get the root shell.

## Installation Tips

When manually building customized system or restoring system from the archive
copy, you need to pay extra attention.

* Don't share swap partition among multiple installations.
* Don't set the file system type (such as ext4), if the installation doesn't
  mount that partition
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

## Post installation tips


### Package selection

```
 $ sudo aptitude -u
```

### EXT4 optimize ideas for note PC

* `sudo tune2fs -o journal_data_writeback /dev/sda2` from other boot media.
* `/etc/fstab option field`:
 	* `noatime,discard,data=writeback,barrier=0,commit=60,errors=remount-ro`

### GRUB

* `grub-theme-starfield`
* `grub2-splashimages`

```
 echo 'GRUB_BACKGROUND="/usr/share/images/grub/Lake_mapourika_NZ.tga"' \
   >> /etc/default/grub
 sudo update-grub
```

### Evolution

Connect to gmail with IMAP/SSL and SMTP/STARTTLS
(Mutt works as backup system if connected with POP3)

### Japanese

* configure Keybinding to be like Mac
    * latin_mode: Muhenkan
    * hiragana_mode: henkan

### exim4

```
 $ sudo dpkg-reconfigure -plow exim4-conf
```

* mail sent by smarthost; received via SMTP or fetchmail
* System mail name: goofy.osamu.debian.net (for hostname=goofy,
  domainname=osamu.debian.net, should be default presented.)

