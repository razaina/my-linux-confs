# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git battery debian github gnu-utils mercurial python ruby screen sudo svn tmux vim-interaction vi-mode vundle git-extras)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/home/razaina/android-sdks/platform-tools/:/home/razaina/android-sdks/tools/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/razaina/Gits/AndBug/lib:/home/razaina/android-ndk-r10d:/home/razaina/Development/android-sdk-linux:/home/razaina/Development/android-sdk-linux/platforms:/home/razaina/Development/android-sdk-linux/tools:/home/razaina/Development/android-sdk-linux/tools/lib:/home/razaina/idasdk66/bin/:/home/razaina/Hexagon_Tools/src/source/:/home/razaina/android-ndk-r10d/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86/bin/arm-linux-androideabi-gdb:/home/razaina/ida-6.6/:/home/razaina/bin:/sbin:/usr/sbin:/usr/local/sbin"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/neko
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
 export LANG=en_US.UTF-8

 #Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='mvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
# source $HOME/.zsh/bindkeys.zshrc
source $HOME/.zsh/modules.zshrc
source $HOME/.zsh/options.zshrc
source $HOME/.zsh/completions.zshrc
source $HOME/.zsh/alias.zshrc
# source $HOME/.zsh/locales.zshrc
source $HOME/.zsh/export.zshrc
source $HOME/.zsh/functions.zshrc
source $HOME/.zsh/misc.zsh
source $HOME/.zsh/prompt2.zshrc

#if [[ -r /usr/local/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    #source /usr/local/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh
#fi

