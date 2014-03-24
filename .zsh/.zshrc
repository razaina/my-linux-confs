# Stolen heavily from StackOverflow

# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return


source $HOME/.zsh/bindkeys.zshrc
source $HOME/.zsh/modules.zshrc
source $HOME/.zsh/options.zshrc
source $HOME/.zsh/completions.zshrc
source $HOME/.zsh/alias.zshrc
# source $HOME/.zsh/locales.zshrc
source $HOME/.zsh/export.zshrc
source $HOME/.zsh/functions.zshrc
source $HOME/.zsh/misc.zsh
source $HOME/.zsh/prompt2.zshrc

compdef _pdf zathura

# Linux ARM920T mini2440
# export PATH=$HOME/mini2440-bootstrap/arm-2008q3/bin:$PATH
# CROSS_COMPILE=arm-none-linux-gnueabi-
# CC="${CROSS_COMPILE}gcc –march=armv5t –mtune=arm920t"
# export CROSS_COMPILE
# export CC

# eval `keychain -q --eval --agents ssh id_ecdsa`
