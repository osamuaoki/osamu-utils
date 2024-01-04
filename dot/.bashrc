# ~/.bashrc: executed by bash(1) for non-login shells.
# shellcheck shell=bash
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# vim:set et sw=2 sts=2:

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# if alternative shell is desired for interactive session, enable followings
#exec zsh -i
#exec fish

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# A command name that is the name of a directory is executed as if
# it were the argument to the cd command.
# This option is only used by interactive shells.
# --> DISABLED bad interaction with fzf
#shopt -s autocd

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
if command -v lesspipe >/dev/null; then
  eval "$(SHELL=/bin/sh lesspipe)"
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ "${debian_chroot:-}" = "" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# force to use color prompt (in reverse)
if [ "$TERM" = "linux" ]; then
  # Linux virtual console: simple
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
elif [ "$UID" != "0" ]; then
  # GUI terminal: reverse with U+E0B0 (private area powerline font) with git branch prompt (opt.)
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(git branch --show-current >/dev/null 2>&1 && echo -n " (=$(git branch --show-current))") $(date +%H:%M:%S)\n\[\033[01;32;48m\]\$\[\033[00m\] '
else
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33;48m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]  $(git branch --show-current >/dev/null 2>&1 && echo -n " (=$(git branch --show-current))") $(date +%H:%M:%S)\n\$\[\033[00m\] '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;

esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  if [ -r ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  # shellcheck disable=1090
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

##############################################################################
# ENVIRONMENT VARIABLES, ITS EXPORT, ALIASES (local customization)
##############################################################################

# User Private Groups: http://wiki.debian.org/UserPrivateGroups
umask 002

# make core file
ulimit -c unlimited

# disable CTRL-S (STOP) on console to avoid confusion
stty stop undef

# set CDPATH
export CDPATH=.:~:~/github:~/salsa:~/rsync:~/Documents:/usr/share

# set PATH of normal users to include "sbin"
PATH="$PATH":/usr/sbin:/sbin

#=============================================================================
# GOOD OLDE VI as baseline editor (minimum resource file)
if [ -r "~/.vimrc" ]; then
  VIMRC="~/.vimrc"
else
  VIMRC="NONE"
fi
if type nvim >/dev/null ; then
  alias nv='nvim'
  alias vi='nvim -u $VIMRC'
  alias v='nvim -u NORC'
  alias sv="SUDO_EDITOR='/usr/bin/nvim -u NORC' /usr/bin/sudoedit"
elif type vim >/dev/null ; then
  alias vi='vim -u $VIMRC'
  alias v='vim -N -u NORC'
  alias sv="SUDO_EDITOR='/usr/bin/vim -N -u NORC' /usr/bin/sudoedit"
else
  unalias vi
  unset VIMRC
fi
if [ -n "$VIMRC" ]; then
  export EDITOR='vi'
  export VISUAL='vi'
  alias vimdiff='vi -d'
  alias view='vi -R'
  alias ex='vi -e'
fi

alias yarn=yarnpkg

# Alternative editors
#   avim:  nvim with AstroNvim (offset avim) -- as ~/bin/avim
#   bvim:  nvim with NvChad (offset bvim)    -- as ~/bin/bvim

export BROWSER=chromium
export MKISOFS="xorrisofs"

#=============================================================================
# DEBIAN (devscripts related)
DEBEMAIL=osamu@debian.org
DEBFULLNAME="Osamu Aoki"
export DEBEMAIL DEBFULLNAME
DEBSIGN_KEYID="3133724D6207881579E95D621E1356881DD8D791"
export DEBSIGN_KEYID
# BTS report using mutt
alias bts="bts --mutt"
# shellcheck disable=SC2139
alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
complete -F _quilt_completion -o filenames dquilt

#=============================================================================
# NORMAL COMMAND ALIASES
# set MC_PWD_DIR upon starting mc as alias
if [ -f /usr/lib/mc/mc.sh ]; then
  . /usr/lib/mc/mc.sh
fi
# mc with both panel pointing the same directory (`. /usr/lib/mc/mc.sh` equivalent)
alias m='. /home/osamu/bin/mc-wrapper.sh'
# gitk related
alias gk="git status && gitk --all"
# sensible tools for html
#alias b=sensible-browser
alias b=google-chrome-stable
#   txt
alias p=sensible-pager
#   office suite
alias o=libreoffice
#   pdf
alias d=evince

# quick cd / mkdir to $1/$1
function xcd () {
  cd "$1/$1"
}

function xmcd () {
  mkdir -p "$1/$1"
  cd "$1/$1"
}

# L10N COMMAND ALIASES
LANG=C.UTF-8
export LANG
alias jo="LANG=ja_JP.UTF-8 libreoffice"
alias jw="LANG=ja_JP.UTF-8 lowriter"
alias jc="LANG=ja_JP.UTF-8 LANGUAGE=ja gnucash"
alias jb="LANGUAGE=ja google-chrome-stable"

#=============================================================================
# FZF fuzzy prompt
# fancy prompt
# shellcheck disable=SC2034
FZF_DEFAULT_OPTS="--prompt=' ⇶ '"
#   find limits deep directory:                   -maxdepth 10
# shellcheck disable=SC2034
FZF_FIND_DEPTH=10
#   find ignores btrfs snapshot backup directory: -name .bss.d
# shellcheck disable=SC2034
FZF_IGNORE_PATH=.bss.d

# fzf -- follow its README.md
if command -v fzf >/dev/null; then
  ## customized to limit 10 levels and print pwd
  ##export FZF_DEFAULT_COMMAND='find . -maxdepth 2'
  FZF_KEYBINDINGS_PATH=~/.bash_fzf_keybindings
  if [ -f "$FZF_KEYBINDINGS_PATH" ]; then
    . "$FZF_KEYBINDINGS_PATH"
  else
    echo "I: missing $FZF_KEYBINDINGS_PATH ... try another"
    FZF_KEYBINDINGS_PATH=/usr/share/doc/fzf/examples/key-bindings.bash
    if [ -f "$FZF_KEYBINDINGS_PATH" ]; then
      . "$FZF_KEYBINDINGS_PATH"
    else
      echo "E: missing $FZF_KEYBINDINGS_PATH"
    fi
  fi
  FZF_COMPLETION_PATH=~/.bash_fzf_completion
  if [ -f "$FZF_COMPLETION_PATH" ]; then
    . "$FZF_COMPLETION_PATH"
  else
    echo "I: missing $FZF_COMPLETION_PATH ... try another"
    FZF_COMPLETION_PATH=/usr/share/doc/fzf/examples/completion.bash
    if [ -f "$FZF_COMPLETION_PATH" ]; then
      . "$FZF_COMPLETION_PATH"
    else
      echo "E: missing $FZF_COMPLETION_PATH"
    fi
  fi
fi

#=============================================================================
# QMK firmware
export QMK_HOME="$HOME/github/qmk/qmk_firmware"
#=============================================================================
# Any extras
