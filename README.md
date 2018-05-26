# osamu-utils
<!---
vim:se tw=78 ai si sts=4 et:
-->

These are trivial scripts to make my life easy.

## Fresh install of system with HAL system

For fresh system (probable with factory reset state SSD with 
"hal newssd /dev/sdb" or similar).

* Default install *even desktopless* from boot USB key.
  (Leave some unused space)
* Boot new system

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

```
 Kill terminal bell
 No limit to scroll
 No F10
 No Keybinding
```

* Packages:

```
 # aptitude -u
```


## Update HAL system

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

To add a new ```<project>```:
```
 $ git submodule add git@github.com:osamuaoki/<project>.git submodule/<project>
```

These commands are meant to be edited to customize their behavior.  So I
intentionally avoid providing functionality via command option for the
simplicity ;-)

These are meant to be used on the Debian system.  (Though, it should work on
any GNU/Linux system such as Ubuntu and Fedora.

## Small utility scripts (bin)

*   git-ime     -- split a commit into multiple commits (imediff2, git)
*   git-zap     -- safer "git clean -fdx"               (git)
*   dpkg-S      -- smarter dpkg -S
*   dpkg-ver    -- compare version strings              (dpkg)
*   usertag ... -- add usertag to a package BTS
*   hal         -- many trivial tasks via sub-commands
    * hal install0          -- setup system (minimum, make sudo ready)
    * hal install1          -- setup system (normal)
    * hal apt               -- log manually installed packages to ~/log
    * hal bkup backup ~/    -- backup entire home directory (restic)
    * hal bkup mount ~/     -- mount restic backup to /mnt (restic)
    * hal dotfiles install  -- setup dotfiles and pbuilder-files
    * hal dotfiles diff     -- check dotfiles and pbuilder-files
    * hal newssd  /dev/sd?  -- factory reset of SSD (hdparam, time)
    * hal update            -- update this ~/bin/* repository
*   git-cvs     -- git cvs sync tool (submodule)
*   odedup      -- dedup tool (submodule)
* ...

These are commands meant to be installed into the BIN directory listed in
$PATH.

## dotfiles

*   ~/.bashrc_alias
*   ~/.bashrc_local
*   ~/.benrc
*   ~/.devscripts
*   ~/.gitconfig
*   ~/.imediff2
*   ~/.pbuilderrc
*   ~/.quiltrc-dpkg
*   ~/.vimrc

These are dotfiles are installed into the HOME directory of the user. 

## pbuilder-files

*   pbuilder/A10ccache
*   pbuilder/B90lintian
*   pbuilder/C10shell

These are pbuilder hook scripts installed into /var/cache/pbuilder/hooks.

## Home directory

*   ~/src/debian (backed up to alioth or its successor)
*   ~/src/github (backed up to github)
*   ~/src/local  (local backup)

## Permissions

To be on safer end:

* Executable: chmod 755 ...
* Documents:  chmod 644 ...
