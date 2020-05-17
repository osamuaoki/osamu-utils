# osamu-utils (v2020-05)
<!---
vim:se tw=78 ai si sts=4 sw=4 et:
-->

These are scripts to set up my typical workstation and meant to be installed
in `~/bin` directory.

Let's go over my recent practices. (My user account is `osamu`.)

## Download the Debian Install ISO image

* [mini.iso](https://d-i.debian.org/daily-images/amd64/daily/netboot/) smallest 47 MB testing
* [debian-testing-amd64-netinst.iso](https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/amd64/iso-cd/) typical 350 MB testing
* [debian-10.4.0-amd64-netinst.iso](https://www.debian.org/CD/netinst/) typical 340 MB stable

Get USB memory and plug in.  If auto mounted by Desktop system, unmount it to
be sure but keep it device accessible. (On pre-existing system):

```
$ sudo unount /dev/sdX
```

Get USB memory initialized as (On pre-existing system):

```
$ sudo cp <name>.iso /dev/sdX
$ sudo sync
```

## Initial install (non-GUI)

Here is how I set up my system `/home` in the btrfs submodule on GPT/UEFI
system.  Notable feature is my home directory is in the btrfs submodule.

* Set BIOS to disable CBM (=disable legacy boot)
* install with USB memory w/o desktop initially as UEFI system
    * split /home and format as btrfs (Debian doesn't allow to use btrfs
      submodule here)
* start the new system as root
* Do the minimal set-up for osamu (uid=1000) from the Linux console on the new
  system:

```
# apt update
# apt install aptitude mc vim sudo locales-all git wget gnupg openssh-client nano-
# adduser osamu sudo
# cd /home
```
Now, btrfs is mounted /home.  Let's make the new system to use the subvolume
instead with Ubuntu style naming starting with `@`.

```
# btrfs subvolume create @home
# cd @home
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

## Set up a minimal GUI desktop system

Basically, fire up `sudo aptitude -u` and select:

* Tasks -> End-user -> GNOME -> task-gnome-desktop
* Install key packages: git gnupg
* GNOME terminal may need to select font to use. (Monospace regular)
* Disable F10 for GNOME terminal
* Copy security related files from private safe storage `.ssh/*` `.gnupg/*` `.getmail/*` if needed.

## Set up a typical GUI desktop system

Let's add trivial scripts to make my life easy.

These are meant to be edited to customize their behavior.  So I intentionally
avoid providing functionality via command option for the simplicity ;-)

These are meant to be used on the Debian system.  (Though, it should work on
any GNU/Linux system such as Ubuntu and Fedora.

Let's clone scripts from this github site.

### Updating scripts without ssh key

This assumes my ssh key isn't around.

```
 $ mkdir ~/bin
 $ git clone https://github.com/osamuaoki/osamu-utils.git ~/bin
```

This lacks some extra scripts but provides mostly usable work environment.

### Updating scripts with ssh key

This assumes my ssh key installed by hand properly.

```
 $ mkdir ~/bin
 $ git clone git@github.com:osamuaoki/osamu-utils.git ~/bin
 $ git submodule update --init --recursive
```

The keep updating with:
```
 $ git pull
 $ git submodule update --init --recursive
```
or
```
 $ hal update
```

Submodules provide some extra scripts.

## Small utility scripts (bin)

*   git-zap     -- safer "git clean -fdx"               (git)
*   dpkg-S      -- smarter dpkg -S
*   dpkg-ver    -- compare version strings              (dpkg)
*   usertag ... -- add usertag to a package BTS
*   hal         -- many trivial tasks via sub-commands
    * hal newssd  /dev/sd?  -- factory reset of SSD (hdparam, time)
    * hal initial-setup     -- initial setup of the new system
    * hal dotfiles install  -- setup public dotfiles and pbuilder-files
    * hal dotfiles diff     -- check public dotfiles and pbuilder-files
    * hal dotfiles backup   -- backup secret and public dotfiles and pbuilder-files
    * hal install           -- setup system (based on ~/.debrc)
    * hal update            -- update this `~/bin/*` repository
* ...

## public dotfiles

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

These are dotfiles are installed into the HOME directory of the user.

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

## Adding some extra scripts

To add a new ```<project>```:
```
 $ git submodule add git@github.com:osamuaoki/<project>.git submodule/<project>
```
