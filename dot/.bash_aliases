##############################################################################
# Local BASH customization sourced by ~/.bashrc
##############################################################################
# vim: sw=2 sts=2 et si ai tw=79:
##############################################################################
# set alias
# html
alias b=sensible-browser
# txt
alias v=sensible-pager
# doc
alias o=libreoffice
# pdf
alias p=evince
# pwd+ ... for prompt like
alias a='echo $(id -un)@$(hostname):$(pwd | sed "s,/home/$(id -un),~,")'
# mc  . .
alias m="mc . ."

alias up="set -x; date --iso=sec;sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y; set +x"
alias ups="set -x; date --iso=sec;sudo sbuild-update -udcar u && set +x; sync"
alias upa="sudo aptitude -u"
alias bts="bts --mutt"
alias gk="git status && gitk --all"
# For LXC
alias cgdo="systemd-run --scope --quiet --user --property=Delegate=yes"
# For systemd
alias s="systemctl"

#### wrap sudo to minimize exposure (w/ check for the 2nd sudo process)
#### https://wiki.archlinux.org/index.php/Running_GUI_applications_as_root#Using_xhost
#### https://wiki.debian.org/Wayland
#### https://support.google.com/chromebook/thread/36971806?hl=en
###xsudo() {
###  /usr/bin/xhost si:localuser:root
###  /usr/bin/sudo "$@"
###  /usr/bin/pgrep /usr/bin/sudo >/dev/null || /usr/bin/xhost -si:localuser:root
###}
# sudoedit to use vi (normally vim)
alias svi="SUDO_EDITOR=/usr/bin/vi /usr/bin/sudoedit"

# schroot development shell (with X)
#alias dev="xhost +local:localhost && schroot -c unstable-dev && xhost -"
alias devs="schroot -c source:unstable-dev"
alias devx="xhost +si:localuser:osamu ; schroot -c chroot:unstable-dev ; xhost -"

