########################################
# ALIAS, FUNCTION and BASH_COMPLETION for them
########################################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
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
alias ben="BEN_CACHE_DIR=~/tmp ben --config=${HOME}/.benrc"


alias ml="getmails -v && mutt"
alias svi="sudo vim"
alias sapt="sudo aptitude -u"
alias up-apt="set -x; sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y; set +x"
alias up-papt="set -x; sudo git-pbuilder update && set +x; sync"
alias upgrade="up-apt && echo "" && up-papt ; sync"
alias bts="bts --mutt"
alias gk="git status && gitk --all"

function mcd { mkdir $1 ; cd $1 ; }
