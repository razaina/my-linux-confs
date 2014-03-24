# Aliases
    alias la='ls -a'
    alias lh='ls -lh'
    alias lah='ls -lah'
    alias -g ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable --group-directories-first'
    #alias -g ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable --group-directories-first -X'
    alias -g G='| grep'
#    alias shutdown='sudo shutdown -h now'
#    alias reboot='sudo reboot'
    alias locate='locate -i -e'
    alias wicd='wicd-curses'
    alias mkdir='mkdir -p'
    #alias mplayer="mplayer2"
    if [ $UID -ne 0 ]; then
        alias reboot='sudo reboot'
        alias halt='sudo halt'
    fi

# Make coreutils more verbose
    for c in cp rm chmod chown rename mv mkdir; do
        alias $c="$c -v"
    done

    # Register specific applications for some file endings
    alias   -s dvi=xdvi
    alias   -s pdf=zathura
