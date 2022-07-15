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
alias a='echo "⇶⇶⇶⇶ $(id -un)@$(hostname):$(pwd | sed "s,/home/$(id -un),~,")"'
#. /usr/lib/mc/mc.sh equivalent
alias m='. /home/osamu/bin/mc-wrapper.sh'
# python3
alias py="python3"

sysupdate_main () {
  set -x; date --iso=sec
  sudo apt-get update && sudo apt-get dist-upgrade -y && \
      sudo apt-get autoremove -y
  set +x
  sync; date --iso=sec
  echo "============================================================================="
}
sysupdate_sbuild () {
  set -x; date --iso=sec
  sudo sbuild-update -udcar $1
  set +x
  sync
  sync; date --iso=sec
  echo "============================================================================="
}

# NORMAL SYSTEM UPDATE
alias up="sysupdate_main && sysupdate_sbuild unstable"

# FULL SYSTEM UPDATE
alias upall="sysupdate_main && \
  sysupdate_sbuild unstable && \
  sysupdate_sbuild testing && \
  sysupdate_sbuild stable && \
  sysupdate_sbuild oldstable"

alias ccd="cd \$(realpath .)"
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

