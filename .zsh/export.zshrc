# Exports
export COLORTERM="yes"
export EDITOR=vim
export GREP_COLOR=31
# export MAIL=${HOME}/Mail
export MAILCHECK=1
export GDK_USE_XFT=1    #   For old gtk applications
export QT_XFT=true      #   For old qt applicatios
export BROWSER=chromium-browser
#export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
export HISTSIZE=25000
export HISTFILE=~/.zsh_history
export SAVEHIST=5000

# Set less options
if [[ -x $(which less) ]]
then
    #export PAGER="less"
    export LESS="--ignore-case --LONG-PROMPT --QUIET --chop-long-lines -Sm --RAW-CONTROL-CHARS --quit-if-one-screen --no-init"
fi

# Set less options
if [[ -x $(which most) ]]
then
    export PAGER="most"
fi

# Set default editor
if [[ -x $(which vim) ]]
then
    export EDITOR="vim"
    export USE_EDITOR=$EDITOR
    export VISUAL=$EDITOR
fi

REPORTTIME=60       # Report time statistics for progs that take more than a minute to run
WATCH=notme         # Report any login/logout of other users
WATCHFMT='%n %a %l from %m at %T.'
MANPAGER=$PAGER

path+=( $HOME/bin /sbin /usr/sbin /usr/local/sbin ); path=( ${(u)path} );
# CDPATH=$CDPATH::$HOME:/usr/local

# Silence Wine debugging output (why isn't this a default?)
WINEDEBUG=-all

# Set grep to ignore SCM directories
if ! $(grep --exclude-dir 2> /dev/null); then
    GREP_OPTIONS="--color --exclude-dir=.svn --exclude=\*.pyc --exclude-dir=.hg --exclude-dir=.bzr --exclude-dir=.git"
else
    GREP_OPTIONS="--color --exclude=\*.svn\* --exclude=\*.pyc --exclude=\*.hg\* --exclude=\*.bzr\* --exclude=\*.git\*"
fi
export GREP_OPTIONS

# environment {{{
######################################################################
# Andere Umgebungsvariablen
######################################################################
  export CC=gcc
  export COLORTERM=yes

  export EDITOR=${EDITOR:-vim}
  export BROWSER=${BROWSER:-elinks}
  export PAGER=${PAGER:-less}
  export READNULLCMD=${READNULLCMD:-$PAGER}
# colors for less without compiled termcap files (curses feature)
  export LESS_TERMCAP_mb=$'\e[01;31m'
  export LESS_TERMCAP_md=$'\e[01;31m'
  export LESS_TERMCAP_me=$'\e[0m'
  export LESS_TERMCAP_se=$'\e[0m'
  export LESS_TERMCAP_so=$'\e[01;44;33m'
  export LESS_TERMCAP_ue=$'\e[0m'
  export LESS_TERMCAP_us=$'\e[01;32m'

  export LESS=XFRaeiM # the XFR is important here: don't mess with the terminal!

  export LC_ALL=${LC_ALL:-en_US.UTF-8}
  export LC_PAPER=${LC_PAPER:-a4}
  # Forcing these values is only harmful...
  # export LC_C=${LC_C:-en_US.UTF-8}
  # export LC_CTYPE=${LC_CTYPE:-en_US.UTF-8}

# }}}

# Java Card
export JC_HOME=$HOME/opt/java_card_kit
