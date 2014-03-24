# ls on cd
#    cd() {builtin cd $@; ls }

# exec 2>>(while read line; do
#       print '\e[91m'${(q)line}'\e[0m' > /dev/tty; print -n $'\0'; done &)

extract() {
   if [[ -z "$1" ]] ; then
      print -P "usage: \e[1;36mextract\e[1;0m < filename >"
      print -P "       Extract the file specified based on the extension"
   elif [[ -f $1 ]] ; then
      case ${(L)1} in
         *.tar.bz2)  tar -jxvf $1	;;
         *.tar.gz)   tar -zxvf $1	;;
         *.bz2)      bunzip2 $1	   ;;
         *.gz)       gunzip $1	   ;;
         *.jar)      unzip $1       ;;
         *.rar)      unrar x $1	   ;;
         *.tar)      tar -xvf $1	   ;;
         *.tbz2)     tar -jxvf $1	;;
         *.tgz)      tar -zxvf $1	;;
         *.zip)      unzip $1	      ;;
         *.Z)        uncompress $1	;;
         *)          echo "Unable to extract '$1' :: Unknown extension"
      esac
   else
      echo "File ('$1') does not exist!"
   fi
}

calendar() {
   if [[ ! -f /usr/bin/cal ]] ; then
      echo "Please install cal before trying to use it!"
      return
   fi

   if [[ "$#" = "0" ]] ; then
      /usr/bin/cal | egrep -C 40 --color "\<$(date +%e| tr -d ' ')\>"
   else
      /usr/bin/cal $@ | egrep -C 40 --color "\<($(date +%B)|$(date +%e | tr -d ' '))\>"
   fi
}

alias cal=calendar

echon() {
   # Convert to normal 0th element access
   local loc=$1
   shift

   echo $@[(w)$loc]
}

mkcd() {
   if [[ -z "$1" ]] ; then
      echo "usage: \e[1;36mmkcd \e[1;0m< directory >"
      echo "       Creates the specified directory and then changes it to pwd"
   else
      if [[ ! -d $1 ]] ; then
         mkdir -p $1 && cd $1
      else
         cd $1
      fi
   fi
}

unkey_host() {
   if [[ -z "$1" ]] ; then
      echo "usage: \e[1;36munkey_host \e[1;0m< host >"
      echo "       Removes the specified host from ssh known host list"
   else
      sed -i -e "/$1/d" $HOME/.ssh/known_hosts
   fi
}

# Compatibility
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$3]}" }

# Begining of Gentoo Specific Functions!!
# Gentoo Linux (http://www.gentoo.org)
if [[ -f /etc/gentoo-release ]] ; then

   # Shamelessly stolen from ciaranm <ciaranm@gentoo.org>
   eportdir() {
      eval "eportdir() { echo $(portageq portdir) ; }"
      eportdir $*
   }

   eoverlays() {
      eval "eoverlays() { echo $(portageq portdir_overlay) ; }"
      eoverlays $*
   }

   # Shamelessly stolen from slarti <slarti@gentoo.org>
   # Modified to add in overlay support
   _useflags() {
      local  global_use local_use overlay_global overlay_local

      global_use=${${${(M)${(f)"$(<$(eportdir)/profiles/use.desc)"}##* - *}/ - *}}
      local_use=${${${(M)${(f)"$(<$(eportdir)/profiles/use.local.desc)"}##* - *}/ - *}#*:}

      overlay_global=""
      overlay_local=""

      for overlay in $(eoverlays) ; do
         if [[ -r ${overlay}/profiles/use.desc ]] ; then
            overlay_global="${overlay_global} ${${(M)${(f)"$(<${overlay}/profiles/use.desc)"}##* - *}/ - *}"
         fi

         if [[ -r ${overlay}/profiles/use.local.desc ]] ; then
            overlay_local="${overlay_local} ${${${(M)${(f)"$(<${overlay}/profiles/use.local.desc)"}##* - *}/ - *}#*:}"
         fi
      done

      global_use="${global_use} ${overlay_global}"
      local_use="${local_use} ${overlay_local}"

      _tags global_use && { compadd "$@" ${(kv)=global_use} }
      _tags local_use && { compadd "$@" ${(kv)=local_use} }
   }

   describe() {
      if [[ -z "$1" ]] ; then
         echo "usage: \e[1;36mdescribe\e[1;0m < use flag > [ < use flag > ]"
         echo "       Prints a description of the use flag"
         return
      fi

      for val in "$@" ; do
         local g_desc="$(sed -ne "s,^\([^ ]*:\)\?$val - ,,p" "${$(eportdir)}/profiles/use.desc" | uniq)"

         if [[ ! -n "$g_desc" ]] ; then
            l_desc="$(sed -ne "s,^\([^ ]*:\)\?$val - ,,p" "${$(eportdir)}/profiles/use.local.desc" | uniq)"
         fi

         if [[ -n "$g_desc" ]] ; then
            echo "\tThe \e[1;32mglobal\e[01;0m use flag '\e[1;32m$val\e[0;0m' is decribed as follows:"
            echo "\t$g_desc"
         elif [[ -n "$l_desc" ]] ; then
            echo "\tThe \e[1;32mlocal\e[01;0m use flag '\e[1;32m$val\e[0;0m' is decribed as follows:"
            echo "\t$l_desc"
         else
            echo "\tThe use flag '\e[1;31m$val\e[0;0m' was not found."
         fi
      done
   }

   syncdate() {
      if [[ ! -x /usr/bin/genlop ]] ; then
         echo "Please emerge genlop for this functionality"
         return
      fi

      date="$(genlop -nr | /usr/bin/tail -n1 | sed -e 's:.*>>> \(.*\)$:\1:')"
      echo "Portage was last synced: ${date}"
   }

   # Shamelessly stolen from ciaranm <ciaranm@gentoo.org>
   efind() {
      local efinddir cat pkg
      efinddir="$(eportdir)"

      case $1 in
         *-*/* )
            pkg="${1##*/}"
            cat="${1%/*}"
            ;;
         ?*)
            pkg=${1}
            cat=$(echon 1 ${efinddir}/*-*/${pkg}/*.ebuild)
            [[ -f $cat ]] || cat=$(echon 1 ${efinddir}/*-*/${pkg}*/*.ebuild)
            [[ -f $cat ]] || cat=$(echon 1 ${efinddir}/*-*/*${pkg}/*.ebuild)
            [[ -f $cat ]] || cat=$(echon 1 ${efinddir}/*-*/*${pkg}*/*.ebuild)
            if [[ ! -f $cat ]] ; then
               return 1
            fi
            pkg=${cat%/*}
            pkg=${pkg##*/}
            cat=${cat#${efinddir}/}
            cat=${cat%%/*}
            ;;
      esac
      echo "${cat}/${pkg}"
   }

   compdef _useflags describe
fi

cdtemp() {
	local t
		t=`mktemp -d`
		echo $t
		builtin cd $t
}

mp3towav(){
	[[ $# -eq 0 ]] && { echo "mp3wav mp3file"; exit 1; }
	for i in "$@"
	do
		# create .wav file name
		local out="${i%/*}.wav"
		[[ -f "$i" ]] && { echo -n "Processing ${i}..."; mpg123 -w "${out}" "$i" &>/dev/null  && echo "done." || echo "failed."; }
	done
}

# 2010-11-24: pretty print `df' output
# (thanks to Axel B. for showing me!)
# df() {
#   if [[ -z "$*" ]]; then
#     command df -TPh | column -t
#   else
#     command df $*
#   fi
# }

cp-p()
{
   strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
      | awk '{
        count += $NF
            if (count % 10 == 0) {
               percent = count / total_size * 100
               printf "%3d%% [", percent
               for (i=0;i<=percent;i++)
                  printf "="
               printf ">"
               for (i=percent;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }
         END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# hashes {{{
######################################################################
# Hashs
######################################################################

hash -d doc=/usr/share/doc
hash -d log=/var/log
hash -d zsh=/usr/share/zsh/functions

# }}}
