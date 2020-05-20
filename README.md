# osamu-utils (v2020-05)
<!---
vim:se tw=78 ai si sts=4 sw=4 et:
-->

These are scripts to set up my typical workstation and meant to be installed
in `~/bin` directory.

Let's go over my recent practices. (My user account is `osamu`.)

## Download the Debian Install ISO image

Download the Debian Install ISO image to use:

* [mini.iso](https://d-i.debian.org/daily-images/amd64/daily/netboot/) smallest 47 MB testing
* [debian-testing-amd64-netinst.iso](https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/amd64/iso-cd/) typical 350 MB testing
* [debian-10.4.0-amd64-netinst.iso](https://www.debian.org/CD/netinst/) typical 340 MB stable

Get a USB memory and plug it in tp an pre-existing system.  If auto mounted by
the Desktop system, unmount it to be sure but keep it device accessible. (On
pre-existing system):

```
$ sudo unount /dev/sdX
```

Get USB memory initialized as (On pre-existing system):

```
$ sudo cp <name>.iso /dev/sdX
$ sudo sync
```

## System install

Here is how I set up my system `/home` in the btrfs submodule on GPT/UEFI
system.  Notable feature is my home directory is in the btrfs submodule.

* Set BIOS to disable CBM (=disable legacy boot)
* install with USB memory w/o desktop initially as UEFI system
    * split `/home` partitioning and format the whole `/home` as btrfs (Debian
      doesn't allow to use btrfs submodule here)
* start the new system as root from the Linux console
* Do the minimal set-up for osamu (uid=1000) from the Linux console on the new
  system:

```
# apt update
# apt install aptitude mc vim sudo locales-all git wget gnupg openssh-client nano-
# adduser osamu sudo
# cd /home
```

Now, btrfs is mounted `/home`.  Let's make the new system to use the subvolume
instead with Ubuntu style naming starting with `@`.

```
# btrfs subvolume create @home
# cd @home`
# mkdir osamu
# chown osamu:osamu osamu
# lsblk -f |grep /home
└─sdb4 btrfs           039aa73c-e87f-4701-88c6-04d83e08af53  106,4G    39% /home
# vim /etc/fstab
 ...
# cat /etc/fstab
 ...
## /home was on /dev/sdb4 during installation
#UUID=039aa73c-e87f-4701-88c6-04d83e08af53 /home           btrfs   defaults        0       0
# `btrfs subvolume create /mnt/@home`
UUID=039aa73c-e87f-4701-88c6-04d83e08af53 /home           btrfs   defaults,subvol=@home        0       0
 ...
```

Restore intended contents of `/home/osamu` which is now at `/home/@home/osamu`
from your back-up media, if desired. (Or, use a copy of newly created template
files at `/home/osamu` to `/home/@home/osamu`).

If you want to have a GUI desktop system, istall it by one of the following
frim the root shell (optional):

* `aptitude`: Tasks -> End-user -> GNOME -> task-gnome-desktop
* `apt install task-gnome-desktop`


## Set up shell environment

Let's make my command shell uses easier. This git repository facilitates it.

These scrips are meant to be edited to customize their behavior.  So I
intentionally avoid providing functionality via command option for the
simplicity ;-)

These are meant to be used on the Debian system.  (Though, it should work on
any GNU/Linux system such as Ubuntu and Fedora.

Let's clone scripts from this github site to your `~/bin`.

First you need to log into your user account.  Here, it is `osamu`.

* If ssh key isn't around:

```
 $ mkdir ~/bin
 $ git clone https://github.com/osamuaoki/osamu-utils.git ~/bin
```

This lacks some extra scripts but provides mostly usable work environment.

* If ssh key is around:

```
 $ mkdir ~/bin
 $ git clone git@github.com:osamuaoki/osamu-utils.git ~/bin
 $ git submodule update --init --recursive
```

Submodules provide some extra scripts.

Thenm use this to set system:

```
$ hal initial-setup
$ hal dotfiles install
$ vim ~/.debrc
 ...
$ hal install
```

Then refine GUI desktop as needed:

* GNOME terminal may need to select font to use. (Monospace regular)
* Disable F10 for GNOME terminal
* Copy security related files from private safe storage `.ssh/*` `.gnupg/*` `.getmail/*` if needed.

## Small utility scripts in `~/bin`

*   git-zap     -- safer "git clean -fdx"               (git)
*   dpkg-S      -- smarter dpkg -S
*   dpkg-ver    -- compare version strings              (dpkg)
*   usertag ... -- add usertag to a package BTS
*   hal         -- many trivial tasks via sub-commands
    * hal newssd  /dev/sd?  -- factory reset of SSD (hdparam, time)
    * hal initial-setup     -- initial setup of the new system
    * hal conf install      -- setup public configuration files
    * hal conf diff         -- check public configuration files
    * hal conf backup       -- backup secret and public configuration files
    * hal conf update       -- update template dot-files and pbuilder-files
    * hal install           -- install predefined packages (based on ~/.debrc)
    * hal install -c        -- check extra packages (based on ~/.debrc)
    * hal update            -- update this `~/bin/*` repository
* ...

## public dot files

* `~/.bashrc_alias`
* `~/.bashrc_local`
* `~/.benrc`
* `~/.devscripts`
* `~/.gitconfig`
* `~/.imediff2`
* `~/.pbuilderrc`
* `~/.quiltrc-dpkg`
* `~/.vimrc`
* `~/.debrc`

These dotfiles are installed into the HOME directory of the user.

## pbuilder-files

* pbuilder/A10ccache
* pbuilder/B90lintian
* pbuilder/C10shell

These are pbuilder hook scripts installed into /var/cache/pbuilder/hooks.

--> I will keep them as they are for now.

## seceret dotfiles

* ~/.ssh/
* ~/.gnupg/
* /etc/exim4/
* ... (TBD)

## Permissions

To be on safer end:

* Executable: chmod 755 ...
* Documents:  chmod 644 ...

## Factory reset of SSD

If SSD is used (suppose it to be `/dev/sdx`), it is a good idea to reset it to
the factory condition using hdparm.

```
 # hal newssd /dev/sdx
```

## Dig out manually installed packages


Basically `hal install -c` is a filtered output of following command:

```
$ aptitude '~i!~prequired!~pimportant!~pstandard!~M'
```

All packages listed in `~/.debrc` are dropped.  Let's see:

```
$ hal install -c
 ...

... Check ... no actual install

1) Console only Desktop
2) GUI Desktop (GNOME)
3) Developer Desktop (C, Python3, ...) 7 GB
4) ... + Documentation
5) ... + TeX tools 13 GB
6) ... + All extras
Enter your choice (1-6): 5

Install 'Developer Desktop (C, Python3, TeX, ...) + Documentation'
-----------------------------------------------------------------------
i  busybox - Tiny utilities for small and embedded systems
i  ca-cacert - CAcert.org root certificates
i  console-setup - console font and keymap setup program
i  discover - hardware identification system
i  dmsetup - Linux Kernel Device Mapper userspace library
i  firmware-linux-nonfree - Binary firmware for various drivers in the Linux kernel (meta-package)
i  font-viewer - Full-featured font preview application for GTK Environments
i  fonts-dejavu-core - Vera font family derivate with additional characters
i  fonts-opensymbol - OpenSymbol TrueType font
i  fzf - general-purpose command-line fuzzy finder
i  grub-common - GRand Unified Bootloader (common files)
i  grub-efi-amd64 - GRand Unified Bootloader, version 2 (EFI-AMD64 version)
i  ibus-mozc - Mozc engine for IBus - Client of the Mozc input method
i  ibus-wayland - Intelligent Input Bus - Wayland support
i  initramfs-tools - generic modular initramfs generator (automation)
i  installation-report - system installation report
i  keyboard-configuration - system-wide keyboard preferences
i  laptop-detect - system chassis type checker
i  linux-config-5.4 - Debian kernel configurations for Linux 5.4
i  linux-config-5.5 - Debian kernel configurations for Linux 5.5
i  linux-image-amd64 - Linux for 64-bit PCs (meta-package)
i  lsb-base - Linux Standard Base init script functionality
i  memtest86+ - thorough real-mode memory tester
i  mutt - text-based mailreader supporting MIME, GPG, PGP and threading
i  popularity-contest - Vote for your favourite packages automatically
i  python3 - interactive high-level object-oriented language (default python3 version)
i  shim-signed - Secure Boot chain-loading bootloader (Microsoft-signed binary)
i  task-ssh-server - SSH server
i  usbutils - Linux USB utilities
i  wireguard-dkms - fast, modern, secure kernel VPN tunnel (DKMS version)
i  xterm - X terminal emulator
```

The initial invocation result of `hal install -c` contains many false
positives.  In order for `hal install -c` to dig out manually installed
packages effectively, you need to mark a automatically installed package as
so.  Somehow, automatically installed packages in early installation process
lacks registration of the automatically installed flag used by `aptitude`.

You can set the automatically installed flag properly by playing with
`aptitude`.  For example, in `aptitude`, I press `l` and input `~n^lib` .
Then, I press `M` over `Installed Packages` line.  You now see many packages
for dependency breakage and pending removal indicated by `B` or `d` under
`Installed Packages`.  Press `+` once over `Installed Packages`.  For `B`
packages, move to each `B` package and press `+` once. For `d` packages, move
to each `d` package and press `+` twice.  (Few more dances on such packages as
`python3` not being automatically installed to mark it automatically installed
until no more removal nor install happen and `hal install -c` becomes
minimal.)  Then you are all set.

## Clean up installed packages to get back to minimal system

For manually de-installing bulk of packages, do the followings from `aptitude`:

 * press 'l' and input:
    `~i!~prequired!~pimportant!~pstandard!~M!~skernel!~sadmin!~stasks!~n^firmware`
 * press 'M' on 'Installed Packages' line or on 'tex' section, etc,
 * press 'm' on key packages like 'vim' 'mc' 'git' 'ssh' ...
 * If pressing '+' on a package causes 'B', you can press '+' again to install
   that package.
 * press 'g' and proceed to remove bulk of packages.

You should get the minimum system by now.  You can get your baseline system by
the following:

```
$ hal install
 ...
```

You can simulate `hal install` without actual package installation by using
`hal install -s`.

## Adding some extra scripts

To add a new ```<project>```:
```
 $ git submodule add git@github.com:osamuaoki/<project>.git submodule/<project>
```

## Installation tips


* Don't share swap partition among multiple installations.
* Don't set the file system type (such as ext4), if the installation doesn't
  mount that partition
* UUID may need to be adjusted when a file system is reformatted with `mkfs` a
  swap partition are reinitialized with `mkswap`.  UUID can be identified
  by `lsblk -f`.
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
