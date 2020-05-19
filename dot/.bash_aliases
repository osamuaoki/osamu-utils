##############################################################################
# Local BASH customization sourced by ~/.bashrc
##############################################################################
# vim: sw=2 sts=2 et si ai tw=79:
##############################################################################
# ALIAS, FUNCTION, and BASH_COMPLETION
##############################################################################
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  if [ -r ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -la'
alias l='ls -CF'

# set alias
alias b=sensible-browser
alias v=sensible-pager
alias o=libreoffice
alias p=evince
alias e=fbreader
alias dq="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
complete -F _quilt_completion $_quilt_complete_opt dq
complete -F _quilt_completion $_quilt_complete_opt dquilt
mkdir -p ~/.cache/ben
alias ben="BEN_CACHE_DIR=~/.cache/ben ben --config=${HOME}/.benrc"


alias ml="date --iso=sec && getmails -v && mutt"
alias sapt="sudo aptitude -u"
alias up-apt="set -x; date --iso=sec;sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y; set +x"
alias up-papt="set -x; date --iso=sec;sudo git-pbuilder update --override-config && set +x; sync"
alias upgrade="up-apt && echo "" && up-papt ; sync"
alias bts="bts --mutt"
alias gk="git status && gitk --all"

function mcd { mkdir $1 ; cd $1 ; }

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# wrap sudo to minimize exposure (w/ check for the 2nd sudo process)
# https://wiki.archlinux.org/index.php/Running_GUI_applications_as_root#Using_xhost
# https://wiki.debian.org/Wayland
# https://support.google.com/chromebook/thread/36971806?hl=en
xsudo() {
  /usr/bin/xhost si:localuser:root
  /usr/bin/sudo $@
  /usr/bin/pgrep /usr/bin/sudo >/dev/null || /usr/bin/xhost -si:localuser:root
}
# sudoedit to use vi (normally vim)
alias svi="SUDO_EDITOR=/usr/bin/vi /usr/bin/sudoedit"

##############################################################################
# ENVIRONMENT VARIABLES, and EXPORT
##############################################################################

# User Private Groups: http://wiki.debian.org/UserPrivateGroups
umask 002

# bash history: shorthand for ignorespace and ignoredups
export HISTCONTROL=ignoreboth:erasedups

# mc related
if [ -f /usr/lib/mc/mc.sh ]; then
  . /usr/lib/mc/mc.sh
fi

# FZF
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
  . /usr/share/doc/fzf/examples/key-bindings.bash
fi

# set CDPATH
export CDPATH=.:/usr/share/doc:~:~/pub/salsa:~/pub/github:~/pub/tmp

# set PATH of normal users to include "sbin"
PATH="${PATH}":/usr/sbin:/sbin

# python distutils
if [ -d ~/.local/bin ] ; then
  PATH=~/.local/bin:"${PATH}"
fi

# user's private bin
if [ -d ~/bin ] ; then
  PATH=~/bin:"${PATH}"
fi
export PATH

export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox
export MKISOFS="xorrisofs"
export GIT_PAGER=

# make core file
ulimit -c unlimited

# devscripts related
DEBEMAIL=osamu@debian.org
DEBFULLNAME="Osamu Aoki"
export DEBEMAIL DEBFULLNAME

# make less more friendly for non-text input files, see lesspipe(1)
if [ -x /usr/bin/lesspipe ]; then
  eval "$(SHELL=/bin/sh lesspipe)"
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='${debian_chroot:+($debian_chroot)}\$ '
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='${debian_chroot:+($debian_chroot)}\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

