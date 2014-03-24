# -*- Mode: SH -*-

# source $HOME/.zsh/vcs_info2.zshrc

local -A pc
 
pc['user']=${1:-'green'}
pc['time']=${2:-'white'}
pc['pwd']=${3:-'yellow'}
pc['com']=${4:-'red'}

# Used VCS use 
# %  vcs_info_printsys 
# for supported systems 
zstyle ':vcs_info:*' enable \
		     bzr \
		     cdv \
		     cvs \
		     darcs \
		     git \
		     hg \
		     mtn \
		     svn

zstyle ':vcs_info:(hg*|git*):*' get-revision true
zstyle ':vcs_info:(hg*|git*):*' check-for-changes true

# rev+changes branch misc
#zstyle ':vcs_info:hg*' formats "(%F{green}%s%F{white})[%i %u %b %m]"
#zstyle ':vcs_info:hg*' actionformats "(%s|%a)[%i%u %b %m]"

# hash changes branch misc
zstyle ':vcs_info:git*' formats "(%F{green}%s%F{white})[%F{yellow}%12.12i%F{white} %u %b %m]"
zstyle ':vcs_info:git*' actionformats "(%s|%a)[%12.12i %u %b %m]"

zstyle ':vcs_info:git*:*' stagedstr '%F{28}●'
zstyle ':vcs_info:git*:*' unstagedstr '%F{11}●'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'

# Mercurial
zstyle ':vcs_info:hg:*' branchformat '%b'
zstyle ':vcs_info:hg*:*' formats '(%F{green}%s%F{white})-[%F{yellow}%12.12i %B%F{red}%b%F{white}]'
zstyle ':vcs_info:hg*:*' get-bookmarks true
zstyle ':vcs_info:hg*:*' check-for-changes true
zstyle ':vcs_info:hg*:*' use-simple true
zstyle ':vcs_info:hg*' actionformats "(%s|%a)[%i%u %b %m]"
zstyle ':vcs_info:hg*:*' get-mq true
zstyle ':vcs_info:hg*:*' get-unapplied true
zstyle ':vcs_info:hg*:*' patch-format "mq(%g):%n/%c %p"
zstyle ':vcs_info:hg*:*' nopatch-format "mq(%g):%n/%c %p"

### hg: Truncate long hash to 12-chars but also allow for multiple parents
# Hashes are joined with a + to mirror the output of `hg id`.
zstyle ':vcs_info:hg+set-hgrev-format:*' hooks hg-shorthash
function +vi-hg-shorthash() {
    local -a parents

    parents=( ${(s:+:)hook_com[hash]} )
    parents=( ${(@r:12:)parents} )
    hook_com[rev-replace]=${(j:+:)parents}

    ret=1
}

# Different branch formats
# [svn|www-1173739]
# zstyle ':vcs_info:*' branchformat '%b-%r'
   
precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
            zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{blue}]'
    } else {
            zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{red}●%F{blue}]'
    }

    vcs_info
    print -Pn "\e]2;%n@%m:%~\a"
}

preexec() { print -Pn "\e]2;%n@%m:$1\a" }

# preexec () { print -Pn "\e]0;$1\a" }

prompt_gentoo_help () {
	cat <<'EOF'
		This prompt is color-scheme-able.  You can invoke it thus:

		prompt gentoo [<promptcolor> [<usercolor> [<rootcolor>]]]

EOF
}


prompt_gentoo_setup () {
setopt noxtrace localoptions
	local prompt_gentoo_prompt=${1:-'blue'}
	local prompt_gentoo_user=${2:-'green'}
	local prompt_gentoo_root=${3:-'red'}

	if [ "$USER" = 'root' ]
	then
		base_prompt="%B%F{$prompt_gentoo_root}%m%k "
	else
		base_prompt="%B%F{$prompt_gentoo_user}%n%k "
	fi
	post_prompt="%b%f%k"


	path_prompt="%B%F{$prompt_gentoo_prompt}%~"
	PROMPT="$base_prompt$path_prompt %# $post_prompt"
	#PS2="$base_prompt$path_prompt %_> $post_prompt"
	PROMPT2='{%_} '
	#PS3="$base_prompt$path_prompt ?# $post_prompt"
	# PS3='%(?..[%B%F{red}%?%f%b] )${vcs_info_msg_0_}'
	RPROMPT='%(?..[%B%F{red}%?%f%b] )${vcs_info_msg_0_}'
}

prompt_gentoo_setup
