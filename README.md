# osamu-utils
<!---
vim:se tw=78 ai si sts=4 et:
-->

These are trivial scripts to make my life easy.  Install it via:

 $ mkdir ~/bin
 $ git clone git@github.com:osamuaoki/osamu-utils.git ~/bin

## Small utility scripts (bin)

*   git-ime     split a commit into multiple commits (imediff2, git)
*   git-zap     safer "git clean -fdx"               (git)
*   dpkg-S      smarter dpkg -S
*   dpkg-ver    compare version strings              (dpkg)
*   usertag ... add usertag to a package BTS
*   hal                   many trivial tasks via sub-commands
  * hal install0          setup system (minimum, make sudo ready)
  * hal install1          setup system (normal)
  * hal apt               log manually installed packages to ~/log
  * hal bkup backup ~/    backup entire home directory
  * hal dotfiles install  setup dotfiles and pbuilder-files
  * hal dotfiles diff     check dotfiles and pbuilder-files

These are commands meant to be installed into the BIN directory listed in
$PATH.

## dotfiles

*   .bashrc_alias
*   .bashrc_local
*   .devscripts
*   .gitconfig
*   .pbuilderrc
*   .quiltrc-dpkg
*   .vimrc

These are dotfiles are installed into the HOME directory of the user. 

## pbuilder-files

*   pbuilder/A10ccache
*   pbuilder/B90lintian
*   pbuilder/C10shell

These are pbuilder hook scripts installed into /var/cache/pbuilder/hooks.

