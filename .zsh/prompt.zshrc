# prompt {{{
######################################################################
# The Prompt
######################################################################
# old stuff
# Hier besteht das Prompt aus dem aktuellen Verzeichnis ($PWD) auf 11
# Zeichen reduziert, einem ',' und der anzahl an laufenden Jobs.
# precmd () {
#   TMPPATH="        "$PWD
#   # SHORTPATH=${(M)TMPPATH%???????????}
#   SHORTPATH=${(M)TMPPATH%?????????}
#   # PS1=$(echo "%{\033[0;36m%}$SHORTPATH%{\033[0m%},%{\033[0;31m%}%j%{\033[0m%}%% ")
#   # PS1="#x:gaMfYa%{ - jdez hvksi dfla*%{ $%}gaau f/ jyvqfu dvyza!"
#   PS1=$(echo "$cyan$SHORTPATH$nocolor,$red%j$nocolor%# ")
#   settitle "zsh: "$PWD
#   # PS1="zsh; "
# }

DIRSTACKSIZE=15
	__update_dirstack() { : }
if [[ -w $HOME/.zsh_dirstack ]]; then
	dirstack=($PWD ${(f)"$(<$HOME/.zsh_dirstack)"})
		__update_dirstack() { print -l ${(Ouaf)"$(dirs -lp)"} >| $HOME/.zsh_dirstack }
fi

# minimalistic prompt - way better!
  PROMPT='%B%U'${SSH_HOSTNAME:-zsh}'%u>%b '
  RPROMPT='%(?..%(130?::%S[%?]%s))%1(j.%B(%j%)%b.)$(__git_prompt_info)$(__dir_is_writable)'

  chpwd() {
    __update_dirstack
    __update_dir_is_writable
    __git_info
  }

# 2010-04-23: Trap interrupt and re-define the error core. This makes
# sense if you want to display in your prompt the return value of a
# command when it failed (%(?..%?)), but are annoyed that Ctrl-c
# (interrupt) also causes to exit abnormally. With the above RPROMPT
# definition, interrupts are sort of discarded...
  TRAPINT()
  {
    return $(( 128 + $1 ))
  }

# 2009-11-28: display a small exclamation mark at in prompt if
#             $PWD is not writable!
  __update_dir_is_writable() {
    [[ -w $PWD ]]
    __dir_writable=$?
  }
  __dir_is_writable() {
    [[ $__dir_writable -eq 1 ]] && print -n '!'
  }

# 2009-11-16: add some git info on right side when entering a git directory
#             if inside git-controlled dir, check branch name every command!
  __is_git_repo() { # check return value
    git rev-parse --git-dir &>/dev/null
  }
  __git_info() {
    if __is_git_repo ; then
      __git_repo=1
      __git_project_name=${__git_project_name:-${${$(readlink \
        -f $(git rev-parse --git-dir 2>|/dev/null)):h}##*/}}
    else
      __git_repo=0
      __git_project_name=
    fi
  }
  __git_branch_name() {
    print ${${${${(f)"$(git branch --no-color \
      2>/dev/null)"}:#[^*]*}##\* }:-no branch}
  }
  __git_prompt_info() {
    [[ __git_repo -eq 1 ]] || return
    [[ -z "$__git_project_name" ]] && __git_info
    print " %B${__git_project_name}%b on %B$(__git_branch_name)%b"
  }

# Bei verbesserungen folgende Nachfrage:
# %R -> aktueller Befehl,
# %r -> Verbesserungsvorschlag
  SPROMPT='zsh: correct '%R' to '%r' ? ([Y]es/[N]o/[E]dit/[A]bort) '

# }}}
