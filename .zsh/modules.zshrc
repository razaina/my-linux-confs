# ZSH Modules
autoload -U compinit && compinit
autoload -U promptinit && promptinit
autoload -U zsh-mime-setup zsh-mime-handler && zsh-mime-setup
autoload -U colors && colors
autoload -U bashcompinit && bashcompinit
autoload -Uz vcs_info
autoload -Uz zsh/terminfo
autoload -U zfinit && zfinit

# clone : permet de cloner le shell courrant
zmodload zsh/clone
# datetime : permet la manipulation des dates nativement et simplement
zmodload zsh/datetime
# files : commandes de manipulation de fichier interne (permet de ne plus avoir de limitation du nombre d'argument par exemple)
# net/socket : permet de manipuler des sockets
# net/tcp : offre le support du protocol TCP (un client irc en zsh et un serveur web existe)
# zpty permet de créer un pty virtuel et de lire/écrire ce qui se passe dedans (à la expect)
# pcre permet de faire du pattern matching avec des expressions régulières
# zkbd permet de manipulater la configuration du clavier de manière conviviale

# Quick ../../..
rationalise-dot() {
   if [[ $LBUFFER = *.. ]]; then
      LBUFFER+=/..
   else
      LBUFFER+=.
   fi
}

zle -N rationalise-dot
bindkey . rationalise-dot

# Copys word from earlier in the current command line
# or previous line if it was chosen with ^[. etc
autoload copy-earlier-word
zle -N copy-earlier-word
bindkey '^[,' copy-earlier-word

# Cycle between positions for ambigous completions
autoload cycle-completion-positions
zle -N cycle-completion-positions
bindkey '^[z' cycle-completion-positions

# Increment integer argument
autoload incarg
zle -N incarg
bindkey '^X+' incarg

# Write globbed files into command line
autoload insert-files
zle -N insert-files
bindkey '^Xf' insert-files

# Play tetris
autoload -U tetris
zle -N tetris
bindkey '^X^T' tetris

# 2008-07-07: insert date
insert-date() { LBUFFER+="$(date +%F)" }
zle -N insert-date
bindkey '^Xd' insert-date

# 2007-04-08: EH07, nice idea! (tcsh-like)
# When Tab is pressed on an empty(!) command line,
# the contents of the directory are printed (`ls`)
# instead of a menu list of all executables:
# % cd /usr/src/
# % <Tab>
# linux-2.6.14.3        9p
# fuse.tar.bz2          thinkpad.tar.gz
  complete-or-list() {
    [[ $#BUFFER != 0 ]] && { zle complete-word ; return 0 }
    echo
    ls
    zle reset-prompt
  }
  zle -N complete-or-list
  bindkey '^I' complete-or-list


autoload zsh/sched

# xargs but zargs
autoload -U zargs

# Calculator
autoload zcalc

# Line editor
autoload zed

# Renaming with globbing
autoload zmv
