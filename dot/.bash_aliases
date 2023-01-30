##############################################################################
# Local BASH customization sourced by ~/.bashrc
##############################################################################
# vim: sw=2 sts=2 et si ai tw=79:
# shellcheck shell=bash
##############################################################################
# update main/chroot system
##############################################################################

preupdate_main() {
  ACNGDISTNAME=/var/cache/apt-cacher-ng/debrep/dists/bookworm
  sudo mkdir -p $ACNGDISTNAME
  cd $ACNGDISTNAME
  if [ -f InRelease ]; then sudo mv -f InRelease InRelease.old; fi
  cd -
}

sysupdate_main() {
  set -x
  date --iso=sec
  #preupdate_main
  sudo apt-get update && sudo apt-get dist-upgrade -y &&
    sudo apt-get autoremove -y
  set +x
  sync
  date --iso=sec
  echo "============================================================================="
}
sysupdate_sbuild() {
  set -x
  date --iso=sec
  sudo sbuild-update -udcar "$1"
  set +x
  sync
  sync
  date --iso=sec
  echo "============================================================================="
}

# SYSTEM UPDATE
alias up="sysupdate_main"
alias upu="sysupdate_sbuild unstable"
alias upx="sysupdate_sbuild testing && sysupdate_sbuild stable && sysupdate_sbuild oldstable"
alias upa="up && upu && upx"

# run X program as root
# wrap sudo to minimize exposure (w/ check for the 2nd sudo process)
# https://wiki.archlinux.org/index.php/Running_GUI_applications_as_root#Using_xhost
# https://wiki.debian.org/Wayland
# https://support.google.com/chromebook/thread/36971806?hl=en
xsudo() {
  /usr/bin/xhost si:localuser:root
  /usr/bin/sudo "$@"
  /usr/bin/pgrep /usr/bin/sudo >/dev/null || /usr/bin/xhost -si:localuser:root
}
