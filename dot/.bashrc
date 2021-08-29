# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# vim:set et sw=4 sts=4:

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
if command -v lesspipe >/dev/null; then
  eval "$(SHELL=/bin/sh lesspipe)"
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# force to use color prompt (in reverse)
if [ "$TERM" = "linux" ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
elif [ "$UID" != "0" ]; then
    # GUI terminal: reverse with U+E0B0 (private area powerline font)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\] ⟫=⟫=⟫\n\[\033[01;32;48m\]\$\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]\$\n\[\033[01;32;48m\]⟫\[\033[00m\] '
    #PS1='⇶ ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]\$ \n\[\033[01;32;48m\]⟫\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]⟫🥷⟫\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]⟫🤖⟫\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]⟫⌨⟫\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]⟫🛠⟫\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]⟫🐚⟫\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]⟫\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]⧫\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]⇶\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]⁈\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]❱\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]⊛\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]⨀\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]⟠\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32;48m\]∋\[\033[00m\] '
else
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33;48m\]⟫⟫\[\033[00m\] '
    #PS1='⇶ ${debian_chroot:+($debian_chroot)}\[\033[01;33;48m\]\u@\h\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]\$ ⇶\n❖\[\033[00m\] '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33;48m\]\u@\h\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]\$\n\[\033[00m\] '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33;48m\]\u@\h\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\] ⇶  ⇶\n\$\[\033[00m\] '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

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
# ENVIRONMENT VARIABLES, and EXPORT
##############################################################################

# User Private Groups: http://wiki.debian.org/UserPrivateGroups
umask 002

# set CDPATH
export CDPATH=.:~:/usr/share/doc

# set PATH of normal users to include "sbin"
PATH="${PATH}":/usr/sbin:/sbin

export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox
export MKISOFS="xorrisofs"

# make core file
ulimit -c unlimited

# devscripts related
DEBEMAIL=osamu@debian.org
DEBFULLNAME="Osamu Aoki"
export DEBEMAIL DEBFULLNAME
DEBSIGN_KEYID="3133724D6207881579E95D621E1356881DD8D791"
export DEBSIGN_KEYID

# mc related
if [ -f /usr/lib/mc/mc.sh ]; then
  . /usr/lib/mc/mc.sh
fi

################# CUSTOMIZATION NOTE ##################################
# fancy prompt
FZF_DEFAULT_OPTS="--prompt='  👹 👺 ⇶ '"
#   find limits deep directory:                   -maxdepth 10
FZF_FIND_DEPTH=10
#   find ignores btrfs snapshot backup directory: -name .bss.d
FZF_IGNORE_PATH=.bss.d
#######################################################################

# fzf -- follow its README.md
if command -v fzf >/dev/null; then
    ## customized to limit 10 levels and print pwd
    ##export FZF_DEFAULT_COMMAND='find . -maxdepth 2'
    FZF_KEYBINDINGS_PATH=~/.bash_fzf_keybindings
    if [ -f $FZF_KEYBINDINGS_PATH ]; then
        # shellcheck disable=1090
        . $FZF_KEYBINDINGS_PATH
    else
        echo "I: missing $FZF_KEYBINDINGS_PATH ... try another"
        FZF_KEYBINDINGS_PATH=/usr/share/doc/fzf/examples/key-bindings.bash
        if [ -f $FZF_KEYBINDINGS_PATH ]; then
            # shellcheck disable=1090
            . $FZF_KEYBINDINGS_PATH
        else
            echo "E: missing $FZF_KEYBINDINGS_PATH"
        fi
    fi
    FZF_COMPLETION_PATH=~/.bash_fzf_completion
    if [ -f $FZF_COMPLETION_PATH ]; then
        # shellcheck disable=1090
        . $FZF_COMPLETION_PATH
    else
      echo "I: missing $FZF_COMPLETION_PATH ... try another"
        FZF_COMPLETION_PATH=/usr/share/doc/fzf/examples/completion.bash
        if [ -f $FZF_COMPLETION_PATH ]; then
            # shellcheck disable=1090
            . $FZF_COMPLETION_PATH
        else
            echo "E: missing $FZF_COMPLETION_PATH"
        fi
    fi
fi


# direnv
if command -v direnv >/dev/null; then
    eval "$(direnv hook bash)"
fi
