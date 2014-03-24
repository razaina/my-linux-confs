# Completion
    # We are lazy -- look up spaces too
    bindkey ' ' magic-space

    # Case insensitivity, partial matching, substitution
    zstyle ':completion:*' matcher-list 'm:{A-Z}={a-z}' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'

    zstyle ':completion:::::' completer _complete _approximate _match
    zstyle ':completion:*:descriptions' format "%{$fg_no_bold[yellow]%}- %d -%{$reset_color%}"
    zstyle ':completion:*:corrections' format "%{$fg_no_bold[yellow]%}- %d - (%{$fg_bold[red]%}errors %e%{$reset_color%}%{$fg_no_bold[yellow]%})%{$reset_color%}"
    zstyle ':completion:*:default' list-prompt '%S%M matches%s'
    zstyle ':completion:*' group-name ''
    zstyle ':completion:*' menu select
    zstyle ':completion:*' verbose yes

    # separate man page sections
    zstyle ':completion:*:manuals' separate-sections true
    zstyle ':completion:*:manuals.(^1*)' insert-sections true

    # zstyle ':completion:*:descriptions' format "%{$fg_no_bold[yellow]%}%U%B%d:%b%u%{$reset_color%}"
    # zstyle ':completion:*:warnings' format '%BNo matches for: %d%b'
    # zstyle ':completion:*' menu select=2
    zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

    # Path Expansion
    zstyle ':completion:*' expand 'yes'
    zstyle ':completion:*' squeeze-shlashes 'yes'
    zstyle ':completion::complete:*' '\\'

    # Dont complete backups as executables
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

    # Use cache
    zstyle ':completion::complete:*' use-cache on
    zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

    # zstyle ':completion:*:*:cd:*' tag-order local-directories path-directories

    # Prevent CVS files/directories from being completed
    # zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
    # zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

    # Allow mistakes
    zstyle ':completion:*:match:*' original only
    #zstyle ':completion:*:approximate:*' max-errors 1 numeric
    zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'

    # [?] Ignore completion functions for commands you don't have
    zstyle ':completion:*:functions' ignored-patterns '_*'

# Colors
# You can also add different colours to the completion list - as displayed in the screenshot below. To be more specific, we'll use the same colours that GNU ls shows with the --color option
    zmodload zsh/complist
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion:*' list-colors 'reply=( "=(#b)(*$VAR)(?)*=00=$color[green]=$color[bg-green]" )'
    zstyle ':completion:*' list-colors ''

# Do not show already selected elements
    zstyle ':completion:*:rm:*' ignore-line yes
    zstyle ':completion:*:mv:*' ignore-line yes
    zstyle ':completion:*:cp:*' ignore-line yes
    zstyle ':completion:*:scp:*' ignore-line yes
    zstyle ':completion:*:ls:*' ignore-line yes
    zstyle ':completion:*:mplayer:*' ignore-line yes
    zstyle ':completion:*:emacs:*' ignore-line yes
    zstyle ':completion:*:vim:*' ignore-line yes
    zstyle ':completion:*:emacsclient:*' ignore-line yes

    # Don't select parent directory on cd
    zstyle ':completion:*:cd:*' ignore-parents parent pwd

#   Sudo completion
    zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
        /usr/sbin /usr/bin /sbin /bin 

# PID completion
    zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=$color[white]=$color[red]"
    # zstyle ':completion:*:*:kill:*:processes'   list-colors "=(#b) #([0-9]#)*=36=31"
    zstyle ':completion:*:*:kill:*'             menu yes select
    zstyle ':completion:*:kill:*'               force-list always
    zstyle ':completion:*:killall:*'            force-list always
    zstyle ':completion:*:processes'            command "ps -au$USER"
    # zstyle ':completion:*:processes-names' command 'ps -e -o comm='
    zstyle ':completion:*:killall:*' command 'ps -au $USER -o cmd'

    # Remove uninteresting users
     zstyle ':completion:*:*:*:users' ignored-patterns \
 	    adm alias apache at bin cron cyrus daemon ftp games gdm guest \
 	    haldaemon halt mail man messagebus mysql named news nobody nut \
 	    lp operator portage postfix postgres postmaster qmaild qmaill \
 	    qmailp qmailq qmailr qmails shutdown smmsp squid sshd sync \
 	    uucp vpopmail xfs
    
    # Remove uninteresting hosts
    zstyle ':completion:*:*:*:hosts-host' ignored-patterns \
	    '*.*' loopback localhost

    zstyle ':completion:*:*:*:hosts-domain' ignored-patterns \
	    '<->.<->.<->.<->' '^*.*' '*@*'

    zstyle ':completion:*:*:*:hosts-ipaddr' ignored-patterns \
	    '^<->.<->.<->.<->' '127.0.0.<->'

    zstyle ':completion:*:ssh:*' tag-order 'users hosts'
    zstyle ':completion:*:ssh:*' group-order users hosts
    zstyle -e ':completion:*:(ssh|scp):*' hosts 'reply=(
		    ${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) \
			    /dev/null)"}%%[# ]*}//,/ }
		    )'
    
    # SSH Completion
    zstyle ':completion:*:scp:*' tag-order \
	    files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
	    
    zstyle ':completion:*:scp:*' group-order \
	    files all-files users hosts-domain hosts-host hosts-ipaddr

    zstyle ':completion:*:ssh:*' tag-order \
	    users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'

   zstyle ':completion:*:ssh:*' group-order \
	   hosts-domain hosts-host users hosts-ipaddr

   # Command File Type Detection
   compctl -g '*.ebuild' ebuild
   compctl -g '*.tex' + -g '*(-/)' latex
   compctl -g '*.dvi' + -g '*(-/)' dvipdf dvipdfm
   compctl -g '*.java' + -g '*(-/)' javac
   compctl -g '*.tar.bz2 *.tar.gz *.bz2 *.gz *.jar *.rar *.tar *.tbz2 *.tgz *.zip *.Z' + -g '*(-/)' extract
   compctl -g '*.mp3 *.ogg *.mod *.wav *.avi *.mpg *.mpeg *.wmv' + -g '*(-/)' mplayer
   compctl -g '*.py' python
   compctl -g '*(-/D)' cd
   compctl -g '*(-/)' mkdir
   
   # Command Parameter Completion
   compctl -z fg
   compctl -j kill
   compctl -j disown
   compctl -u chown
   compctl -u su
   compctl -c sudo
   compctl -c which
   compctl -c type
   compctl -c hash
   compctl -c unhash
   compctl -o setopt
   compctl -o unsetopt
   compctl -a alias
   compctl -a unalias
   compctl -A shift
   compctl -v export
   compctl -v unset
   compctl -v echo
   compctl -b bindkey

    _force_rehash() {
	    (( CURRENT == 1 )) && rehash
		    return 1	# Because we didn't really complete anything
    }

    zstyle ':mime:*' mailcap ~/.mailcap /usr/local/etc/mailcap


    # specify the sort order
    zstyle ':completion:*' file-sort name
    zstyle ':completion:*:*:(zathura|xpdf|xdvi):*' file-sort time

# 2008-08-16: massively useful: try to extract file names from previous
# command. If there is none, also check the two commands before the previous.
# this assumes that you copied, moved, created or downloaded files in the
# current directory (unless the file contains a path name). Also, when files
# contain question marks these are almost surely the indicator for a web page
# that was downloaded, so the garbage after the ? is ignored. If a file is
# prefixed by something like user@host: (like with scp), this prefix is also
# removed. Only files that really exist and with names longer than three
# characters are taken into account.
  _extract_files() {
    setopt localoptions extendedglob functionargzero nullglob noglobsubst
    integer back=${1:-1}
    local expl args files dirs
    args=(${(z)${history[$[HISTCMD-back]]}})
    shift args # remove command
    for f in $args; do
      # ignore options and short strings
      [[ $f == -* || $#f -le 3 ]] && continue
      local -U possible
      possible=($f ${f:t} ${f##*:})
      # if it's a messed-up url, try to glob from filename
      [[ $#f -gt 5 && $f == (#b)([^\?]##)\?* ]] && possible+=(${match[1]:t}*)
      for p in $possible; do
        [[ -f $~p ]] && files+=($~p)
        [[ -d $~p ]] && dirs+=($~p)
      done
    done
    if (( $#files + $#dirs )); then
      local ret=1
      _tags files directories
      while _tags; do
        _requested files expl 'files from previous command' \
          compadd -- $files && ret=0
        _requested directories expl 'directories from previous command' \
          compadd -- $dirs && ret=0
        (( ret )) || break
      done
    else
      (( back == 3 )) && _message 'no file names found' && return 1
      (( back++ )) && $0 $back # call this function again
    fi
  }
  zle -C extract-files complete-word _generic
  bindkey '^Xf' extract-files
  zstyle ':completion:extract-files:*' completer _extract_files
  zstyle ':completion:extract-files:*' matcher-list 'b:=*'
# don't list directories unless there are no files
  zstyle ':completion:extract-files:*' tag-order files directories

# }}}
