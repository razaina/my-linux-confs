# Keybindings {{{
bindkey -e

#bindkey "\e[1~" beginning-of-line # Home
#bindkey "\e[4~" end-of-line # End
#bindkey "\e[5~" beginning-of-history # PageUp
#bindkey "\e[6~" end-of-history # PageDown
#bindkey "\e[2~" quoted-insert # Ins
#bindkey "\e[3~" delete-char # Del
#bindkey "\e5C" forward-word
#bindkey "\eOc" emacs-forward-word
#bindkey "\eOd" emacs-backward-word
#bindkey "\e\e[C" forward-word
#bindkey "\e\e[D" backward-word
# for rxvt
#bindkey "\e[7~" beginning-of-line # Home
#bindkey "\e[8~" end-of-line # End
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
#bindkey "\eOH" beginning-of-line
#bindkey "\eOF" end-of-line
# for freebsd console
#bindkey "\e[H" beginning-of-line
#bindkey "\e[F" end-of-line

#bindkey "^[[A" history-search-backward
#bindkey "^[[B" history-search-forward

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
tcsh-backward-delete-word () {
	local WORDCHARS="${WORDCHARS:s#/#}"
	zle backward-delete-word
}

tcsh-backward-word () {
	local WORDCHARS="${WORDCHARS:s#/#}"
	zle emacs-backward-word
}

tcsh-forward-word () {
	local WORDCHARS="${WORDCHARS:s#/#}"
	zle emacs-forward-word
}

zle -N tcsh-backward-delete-word
zle -N tcsh-backward-word
zle -N tcsh-forward-word

bindkey '\e^?' tcsh-backward-delete-word
bindkey '[D' tcsh-backward-word
bindkey '[C' tcsh-forward-word
bindkey "^[[3~" delete-char



# }}}
