# Stolen heavily from StackOverflow
autoload -U compinit promptinit
compinit
promptinit

export PS1="\[\e[36;1m\]\u@\[\e[32;1m\]\H> \[\e[0m\]"
#Android PATH
export PATH=/home/razaina/android-sdks/platform-tools/:/home/razaina/android-sdks/tools/:$PATH
setopt HIST_IGNORE_DUPS

source $HOME/.zsh/bindkeys.zshrc
source $HOME/.zsh/modules.zshrc
source $HOME/.zsh/options.zshrc
source $HOME/.zsh/completions.zshrc
source $HOME/.zsh/alias.zshrc
source $HOME/.zsh/locales.zshrc
source $HOME/.zsh/export.zshrc
source $HOME/.zsh/functions.zshrc
source $HOME/.zsh/misc.zsh
source $HOME/.zsh/prompt2.zshrc


