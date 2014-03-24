# misc {{{
######################################################################
# Sonstiges
######################################################################
# Umask: Wird für gewöhmlich bei der Erstellung von Dateien von 0777 bzw. 0666
# abgezogen. 0666-066 = 0600 -> -rw-------; 0777-066 = 0711 -> -rwx--x--x
  umask 066

# Benachrichtigung darüber, wer Shells öffnet und schließt. Nervig.  ;)
# watch=(notme)
# LOGCHECK=120
# WATCHFMT='%n %a %l from %m at %t.'

# 2006-04-24:
  flv2mpeg() {
    if [[ -z "$1" || ! -e "$1" ]]; then
      echo Usage: $0 VideoFile.flv
      echo Use http://keepvid.com to download the FLV file.
    else
      ffmpeg -i $1 -ab 56 -ar 22050 -b 500 -s 320x240 ${1:r}.mpeg
    fi
  }

# 2006-08-24: Derive für den Mathe-LK... :-(
# Funktioniert nur mit einem Update auf 6.1!
#   derive() {
#     ulimit -v unlimited
#     ulimit -n unlimited
#     wine $HOME/.wine/drive_c/Programme/Derive\ 6/Derive6.exe
#   }

# 2007-08-28: list videos
  lsvid() {
    for t in flv avi wmv mpeg; do
      echo -e -- "$bg[red]${t:u}$reset_color" ------------------------------------------------------------
      ls *.${t}(.N)
    done
  }

# presentation urxvt: big font, no transparency
  alias VX="urxvt +tr -fg white -bg black -font '-*-terminus-medium-*-*-*-20-*-*-*-*-*-iso10646-*'"

# 2008-03-05
  histgrep () { fc -fl -m "*(#i)$1*" 1 | grep -i --color $1 }

# 2008-03-26: ^O expands "vim txt" to "vim *txt<Tab>"
# very useful if you only remember a fragment of the
# file name and want to show the matches
# expand-to-starword () {
#   # lastword=${"${=LBUFFER}"[-1]}
#   # LBUFFER=${LBUFFER/%$lastword/*$lastword}
#   LBUFFER[(w)-1]="*$LBUFFER[(w)-1]"
#   zle complete-word
# }
# zle -N expand-to-starword
# bindkey '^O' expand-to-starword
# 2008-09-04: cleaner and better solution:
  zle -C match-arbitrary-position complete-word _generic
  zstyle ':completion:match-arbitrary-position:*' completer _complete
  zstyle ':completion:match-arbitrary-position:*' matcher-list 'm:{A-Za-z}={a-zA-Z} l:|=* r:|=*'
  bindkey '^O' match-arbitrary-position

  xdvi() { command xdvi ${*:-*.dvi(om[1])} }
  feh()  { print displaying ${*:-*(om[1])}; command feh ${*:-*(om[1])} }

# list-choices at almost every key stroke - annoying!
# self-insert() {
#   zle .self-insert
#   if [[ $LBUFFER[-3,-1] == [-[:alnum:]_.](#c3) ]]; then
#     zle forward-char
#     zle list-choices
#   fi
# }
# zle -N self-insert

# from stract's config
  function makepasswords()
  {
    perl <<-EOPERL
    my @a = ("a".."z","A".."Z","0".."9",(split //, q{#@,.<>$%&()*^}));
    for (1..10) {
        print join "", map { \$a[rand @a] } (1..rand(3)+7);
        print qq{\n}
    }
# the following line has to start with a regular tab charater! :(
	EOPERL
  }

# youtube!
  YT() {
    youtube-dl -tb "$@"
    local download
    download=( *.(flv|mp4)(om[1]) )
    #print -s "ffmpeg -i $download -ar 44100 -ab 192k -ac 2 ${download:r}.mp3 " # store in history
    print -s "ffmpeg -i $download -acodec copy ${download:r}.mp3 " # store in history
  }
  alias YT=noglob\ YT

# }}}

# {{{ If there's something else to clean up locally...
  if [[ -r $HOME/.zsh/zshrc.local.end ]]; then
    source $HOME/.zsh/zshrc.local.end
  fi
# }}}

# Avoid starting the shell with a "dirty" $?
  true
# }}}

# vim:set sw=2 fdm=marker nowrap: EOF
