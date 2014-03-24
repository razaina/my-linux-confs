# A collection of vcs_info usage examples

### Running vcs_info #########################################################

# As always, there's more than one way to skin a cat. Running vcs_info is no
# exception. Here is a rundown of three common ways to get it into action.
#
# All three ways need vcs_info to be marked for autoloading first, so you'd
# do this somewhere in your setup:

autoload -Uz vcs_info

# Episode I: "The prompt_subst way"
# Also known as the Quick-Start-Way. Probably the simplest way to add
# vcs_info functionality to existing setups. You just drop a vcs_info call
# to your `precmd' (or into a `precmd_functions[]' entry) and include a
# single-quoted ${vcs_info_msg_0_} in your PS1 definition:

precmd() { vcs_info }
# This needs prompt_subst set, hence the name. So:
setopt prompt_subst
PS1='%!-%3~ ${vcs_info_msg_0_}%# '

# Episode II: "The way of the psvar"
# With $psvar you got a simple way to get user defined things into your
# prompt without having to set `prompt_subst', which requires extra
# attention to quoting if you like characters like ` in your prompt...
# As described in <http://xana.scru.org/xana2/quanks/vcsinfoprompt/>:

precmd() {
    psvar=()

    vcs_info
    [[ -n $vcs_info_msg_0_ ]] && psvar[1]="$vcs_info_msg_0_"
}

# You can now use `%1v' to drop the $vcs_info_msg_0_ contents in your prompt;
# like this:

PS1="%m%(1v.%F{red}%1v%f.)%# "

# Episode III: "The justsetitinprecmd way"
# This is the way I prefer. When you see it, you may think "Setting that
# variable in precmd() each time? What a waste..."; but let me assure you,
# you're running vcs_info already, setting one variable is not an issue.
#
# You're getting the benefit of being able to programmatically setting your
# prompt, which is nice especially when you're going to do weird things in
# there anyway. Here goes:

precmd() {
    # As always first run the system so everything is setup correctly.
    vcs_info
    # And then just set PS1, RPS1 and whatever you want to. This $PS1
    # is (as with the other examples above too) just an example of a very
    # basic single-line prompt. See "man zshmisc" for details on how to
    # make this less readable. :-)
    if [[ -n ${vcs_info_msg_0_} ]]; then
        # Oh hey, nothing from vcs_info, so we got more space.
        # Let's print a longer part of $PWD...
        PS1="%5~%# "
    else
        # vcs_info found something, that needs space. So a shorter $PWD
        # makes sense.
        PS1="%3~${vcs_info_msg_0_}%# "
    fi
}


### check-for-changes just in some places ####################################

# Some backends (git and mercurial at the time of writing) can tell you
# whether there are local changes in the current repository. While that's
# nice, the actions needed to obtain the information can be potentially
# expensive. So if you're working on something the size of the linux kernel
# or some corporate code monstrosity you may want to think twice about
# enabling the `check-for-changes' style unconditionally.
#
# Zsh's zstyle configuration system let's you do some magic to enable styles
# only depending on some code you're running.
#
# So, what I'm doing is this: I'm keeping my own projects in `~/src/code'.
# There are the projects I want the information for most. They are also
# a lot smaller than the linux kernel so the information can be retrieved
# instantaneously - even on my old laptop at 600MHz. And the following code
# enables `check-for-changes' only in that subtree:

#zstyle -e ':vcs_info:git:*' \
#    check-for-changes 'estyle-cfc && reply=( true ) || reply=( false )'
#
#function estyle-cfc() {
#    local d
#    local -a cfc_dirs
#    cfc_dirs=(
#        ${HOME}/src/code/*(/)
#    )
#
#    for d in ${cfc_dirs}; do
#        d=${d%/##}
#        [[ $PWD == $d(|/*) ]] && return 0
#    done
#    return 1
#}


### Hook Examples ############################################################

# A number of examples in this file revolve around the concept of `hooks'
# in vcs_info. Hooks are places in vcs_info where you may put in your
# own code to achieve something "totally awesome"[tm].
#
# Hooks can be confusing. It's hard to keep track of what's going on.
# In order to help you with that vcs_info can output some debugging
# information when it processes hooks. This will tell you which hooks
# are being run and which functions are attempted to run (and if the
# functions in question were found or not).
#
# If you feel like you need to see what's attempted and where, I suggest
# you use the following line and see for yourself.
zstyle ':vcs_info:*+*:*' debug true

# You can just comment it out (or disable it) again when you've seen enough.
# Debugging is off by default - of course.
zstyle ':vcs_info:*+*:*' debug false

# Further down, every example that uses a function named `+vi-*' uses a hook.


### Truncate Long Hashes

### Truncate a long hash to 12 characters (which is usually unique enough)
# NOTE: On Mercurial this will hide the second parent hash during a merge
# (see an example below on how to retain both parents)
# Use zformat syntax (remember %i is the hash): %12.12i

# git:
zstyle ':vcs_info:git*' formats "(%s)-[%12.12i %b]-" # hash & branch

# hg:
# First, remove the hash from the default 'branchformat':
zstyle ':vcs_info:hg:*' branchformat '%b'
# Then add the hash to 'formats' as %i and truncate it to 12 chars:
zstyle ':vcs_info:hg:*' formats ' (%s)-[%12.12i %b]-'

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

### Display the existence of files not yet known to VCS

### git: Show marker (T) if there are untracked files in repository
# Make sure you have added staged to your 'formats':  %c
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='T'
    fi
}


### Compare local changes to remote changes

### git: Show +N/-N when your local branch is ahead-of or behind remote HEAD.
# Make sure you have added misc to your 'formats':  %m
zstyle ':vcs_info:git*+set-message:*' hooks git-st
function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    # for git prior to 1.7
    # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    (( $ahead )) && gitstatus+=( "+${ahead}" )

    # for git prior to 1.7
    # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
    (( $behind )) && gitstatus+=( "-${behind}" )

    hook_com[misc]+=${(j:/:)gitstatus}
}

### git: Show remote branch name for remote-tracking branches
zstyle ':vcs_info:git*+set-message:*' hooks git-remotebranch

function +vi-git-remotebranch() {
    local remote

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    if [[ -n ${remote} ]] ; then
        hook_com[branch]="${hook_com[branch]} [${remote}]"
    fi
}


### hg: Show marker when the working directory is not on a branch head
# This may indicate that running `hg up` will do something
# NOTE: the branchheads.cache file is not updated with every Mercurial
# operation, so it will sometimes give false positives. Think of this more as a
# hint that you might not be on a branch head instead of the final word.
zstyle ':vcs_info:hg+set-hgrev-format:*' hooks hg-storerev
zstyle ':vcs_info:hg+set-message:*' hooks hg-branchhead

# The hash is available in the hgrev-format hook, store a copy of it in the
# user_data array so we can access it in the second function
function +vi-hg-storerev() {
    user_data[hash]=${hook_com[hash]}
}

function +vi-hg-branchhead() {
    local branchheadsfile i_tiphash i_branchname
    local -a branchheads

    local branchheadsfile=${hook_com[base]}/.hg/branchheads.cache

    # Bail out if any mq patches are applied
    [[ -s ${hook_com[base]}/.hg/patches/status ]] && return 0

    if [[ -r ${branchheadsfile} ]] ; then
        while read -r i_tiphash i_branchname ; do
            branchheads+=( $i_tiphash )
        done < ${branchheadsfile}

        if [[ ! ${branchheads[(i)${user_data[hash]}]} -le ${#branchheads} ]] ; then
            hook_com[revision]="^ ${hook_com[revision]}"
        fi
    fi
}


### Run vcs_info selectively to increase speed in large repos ################

# The following example shows a possible setup for vcs_info which displays
# staged and unstaged changes in the vcs_info prompt and prevents running
# it too often for speed reasons.


# Allow substitutions and expansions in the prompt, necessary for
# using a single-quoted $vcs_info_msg_0_ in PS1, RPOMPT (as used here) and
# similar. Other ways of using the information are described above.
setopt promptsubst
# Load vcs_info to display information about version control repositories.
autoload -Uz vcs_info

# Check the repository for changes so they can be used in %u/%c (see
# below). This comes with a speed penalty for bigger repositories.
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true


# Default to running vcs_info. If possible we prevent running it later for
# speed reasons. If set to a non empty value vcs_info is run.
FORCE_RUN_VCS_INFO=1

# Only run vcs_info when necessary to speed up the prompt and make using
# check-for-changes bearable in bigger repositories. This setup was
# inspired by Bart Trojanowski
# (http://jukie.net/~bart/blog/pimping-out-zsh-prompt).
#
# This setup is by no means perfect. It can only detect changes done
# through the VCS's commands run by the current shell. If you use your
# editor to commit changes to the VCS or if you run them in another shell
# this setup won't detect them. To fix this just run "cd ." which causes
# vcs_info to run and update the information. If you use aliases to run
# the VCS commands update the case check below.
zstyle ':vcs_info:*+pre-get-data:*' hooks pre-get-data
+vi-pre-get-data() {
    # Only Git and Mercurial support and need caching. Abort if any other
    # VCS is used.
    [[ "$vcs" != git && "$vcs" != hg ]] && return

    # If the shell just started up or we changed directories (or for other
    # custom reasons) we must run vcs_info.
    if [[ -n $FORCE_RUN_VCS_INFO ]]; then
        FORCE_RUN_VCS_INFO=
        return
    fi

    # If we got to this point, running vcs_info was not forced, so now we
    # default to not running it and selectively choose when we want to run
    # it (ret=1 means run it, ret=0 means don't).
    ret=1
    # If a git/hg command was run then run vcs_info as the status might
    # need to be updated.
    case "$(fc -ln $(($HISTCMD-1)))" in
        git*)
            ret=0
            ;;
        hg*)
            ret=0
            ;;
    esac
}

# Call vcs_info as precmd before every prompt.
prompt_precmd() {
    vcs_info
}
add-zsh-hook precmd prompt_precmd

# Must run vcs_info when changing directories.
prompt_chpwd() {
    FORCE_RUN_VCS_INFO=1
}
add-zsh-hook chpwd prompt_chpwd

# Display the VCS information in the right prompt. The {..:- } is a
# workaround for Zsh below 4.3.9.
RPROMPT='${vcs_info_msg_0_:- }'


### Quilt support ############################################################

# Vcs_info does its best to support the patch management system quilt
# <http://savannah.nongnu.org/projects/quilt>. The information gathered by
# the quilt support always (and I'm saying always, because there are two
# ways quilt support can be active - see "man zshcontrib" for details)
# ends up in the `%Q' replacement in formats.
#
# Quilt support is also disabled by default. To turn its `addon' mode
# on for all backends, do:
zstyle ':vcs_info:*' use-quilt true

# Then use `%Q' somewhere in the `formats' and `actionformats' styles:
zstyle ':vcs_info:*' formats " (%s)-[%b%Q]-"
zstyle ':vcs_info:*' actionformats " (%s)-[%b%Q|%a]-"

# In the quilt support code, the zstyle context changes a little, it's now:
#       :vcs_info:<vcs>.quilt-<quiltmode>:*:*
# "<vcs>" is the version-control-system string and "<quiltmode>" is either
# `addon' or `standalone'. So, if you'd use quilt on top of CVS, the
# context becomes ":vcs_info:cvs.quilt-addon:*:*".

# That's almost all you need to know. Almost.
#
# Quilt support has a standalone mode. Even though quilt is not really
# a version control system, it keeps track of patches. It can work on top
# of a real VCS (like subversion or CVS - which is covered by addon mode)
# or apply patches to a normal directory tree that's not under version
# control. The debian project does this for a large number of packages,
# during their automatic build process.
# The `use-quilt' style only enables addon-mode, because for standalone
# mode we'd have to try to detect whether quilt is "active" in a directory.
# You can fine-tune that "detection" using the `quilt-standalone' style.
# If the value of that style is a function name, that function is executed
# without arguments to determine whether quilt-detection should be attempted.
# It's the most powerful way of doing this and we'll give a simple
# example later.

# First let's assume you want standalone mode to be active only in
# /usr/src/debian, ~/src/debian and their subdirectories. That's simple:

typeset -a foobar
foobar=(
    /usr/src/debian
    ~/src/debian
)
zstyle ':vcs_info:*' quilt-standalone foobar

# As mentioned earlier, using a function in this style is more powerful:
function foobar() {
    # You can do any sort of wicked wizardry here. This example just
    # checks if we're in "/usr/src/debian" or a subdirectory and if so
    # enables standalone detection.
    [[ $PWD == /usr/src/debian(|/*) ]] && return 0

    # Returning non-zero means false, which means don't enable the
    # "detection".
    return 1
}

# In standalone-mode, vcs_info pretends as if quilt actually was a VCS.
# Well, kind of. The vcs string is set to '-quilt-'. So let's define a
# format just for that mode:
zstyle ':vcs_info:-quilt-:*' formats " [%s%Q]-"

# As with other format insertions, you got total control over what is being
# inserted. The `%Q' insertion is controlled by the `quiltformat' and
# `quilt-nopatch-format' styles.

# quiltformat (default: "%p (%n applied)")
# The `%p' replacement tells you which patches are applied. `%n' tells you
# How many patches are applied. `%u' and `%N' do the same for unapplied patches.
#
# Now you might say, that's way too much. That'll eat up my entire screen if I
# all my 1002 patches applied. Well, true.
# By default, `%p' contains the top-most applied patch. `%u' says contains the
# number of unapplied patches and is therefore the same as `%c'.
# There are two hooks you can use to setup what these contain. Those would be
# `gen-applied-string' and `gen-unapplied-string'. We'll go with the default
# here... ...no need to go into every insane detail.
zstyle ':vcs_info:*' quiltformat '#%p [%n|%c]'

# quilt-nopatch-format (default: "no patch applied")
zstyle ':vcs_info:*' quilt-nopatch-format '#cleeaaaaan!1!!'

# To retrieve information about unapplied patches, vcs_info invokes `quilt'
# itself. Even though that's pretty quick, it's not needed for the default
# behaviour. If we want to have `%c' and `%u' to contain meaningful data,
# we have to enable retrieval of unapplied data:
zstyle ':vcs_info:*' quilt-get-unapplied true

# With quilt, the location of its patches are configurable. It's either
# $QUILT_PATCHES or `patches' if that's unset. Let's assume we're a debian
# developer and want $QUILT_PATCHES to always be `debian/patches' in stand-
# alone mode:
zstyle ':vcs_info:-quilt-.quilt-standalone:*:*' quilt-patch-dir debian/patches

# Since we're a debian developer, we also have some packages of our own,
# and so we want addon mode to also use a $QUILT_PATCHES value of
# `debian/patches' in some directories. In the other directories we never
# want the default `patches' though but a dedicated place for them.
# Say `~/patches/<repository-name>'. Now we'll use some evaluated-style
# magic to achieve all that:
zstyle -e ':vcs_info:*.quilt-addon:*:*' quilt-patch-dir 'my-patches-func'

# That runs something called `my-patches-func', and the value of $reply is
# used as the value for the `quilt-patch-dir' style. We'll define the thing
# as a function - as the name suggests:

function my-patches-func() {
    local p
    # As the tidy debian developer we are, we're keeping our packages
    # in VCSs and they are located in one place `~/src/mypkgs/'
    if [[ $PWD == ${HOME}/src/mypkgs(|/*) ]]; then
        reply=( debian/patches )
        return 0
    fi

    # Now the part about the dedicated directory is a little trickier.
    # It requires some knowledge of vcs_info's internals. Not much though.
    # Everything about this is described in the manual because this
    # variable (plus a few others) may be of interest in hooks, where
    # they are available, too.
    #
    # The variable in question here is `$rrn' which is an abbreviation
    # of repository-root-name. if you're in
    #   /usr/src/zsh/Functions
    # and the repository being
    #   /usr/src/zsh
    # then the value of `$rrn' is `zsh'. Now in case the variable is
    # empty (it shouldn't at this point, but you never know), let's
    # drop back to quilt's default "patches".
    if [[ -z ${rrn} ]]; then
        reply=( patches )
        return 0
    fi

    # If we're here, there's something in $rrn, so:
    p="${HOME}/patches/${rrn}"
    if [[ ! -d $p ]]; then
        # ...and while we're at it, make sure it exists...
        mkdir -p "$p"
    fi
    reply=( $p )
}

# And finally, let's use the `post-quilt' hook to let vcs_info help us
# with setting the $QUILT_PATCHES variable. Since vcs_info already knows
# which $QUILT_PATCHES value is correct, it should just export that variable
# for us. No need to configure something twice when it can work
# automatically. :-)

# Register the hook:
zstyle ':vcs_info:*+post-quilt:*:*' hooks set-quilt-patches

# Define the corresponding function:
function +vi-set-quilt-patches() {
    # The `post-quilt' hook functions are called with three arguments:
    #   $1      the mode (`addon' vs. `standalone').
    #   $2      the path-name of the detected patches directory.
    #   $3      the path-name of the `.pc' directory (or "-nopc-" if it
    #           could not be found).
    # So, what we're after is in $2 already, which makes this function
    # rather trivial:
    export QUILT_PATCHES="$2"
    return 0
}

# This would take care of all the dedicated-patches-directory-in-${HOME}
# from earlier examples, too.


### Using vcs_info from CVS ##################################################

# You've decided you desperately need a newer feature of vcs_info than
# there is in your installed version of zsh.  That's possible, but be aware
# that you are choosing not only the newest features but potentially also
# the newest bugs of vcs_info. Also note, that vcs_info from CVS *may* rely
# on features of zsh that are only available in a newer version than you
# got installed on your system.
#
# So, now that the warnings are out of the way - let's cut to the chase:
# First you'll need to decide where to put the files from CVS. Many people
# keep a directory for personal function files such as `~/.zfuncs' or
# similar. That's what we'll use here.
#
# Step one: "get the thing from CVS"
#  % mkdir -p ~/.zfuncs
#  % cd ~/.zfuncs
#  % cvs -z3 -d:pserver:anonymous@zsh.cvs.sourceforge.net:/cvsroot/zsh \
#        co -d VCS_Info -PA zsh/Functions/VCS_Info
#
# There, now you got a `~/.zfuncs/VCS_Info' directory that has all the files
# you need. Whenever you feel like updating the checkout, you can do:
#  % cd ~/.zfuncs/VCS_Info; cvs up; cd -
#
# Step two: "Tell zsh to use the checkout"
# Zsh looks for function files in the directories listed in $fpath. If
# you're already using `~/.zfuncs' you probably have something like this
# in your setup:

fpath=( ~/.zfuncs $fpath )

# Note, that the private directory is added in *front* of the default
# value, so that files from that directory supersede the ones from system
# directories. To add the VCS_Info subtree (excluding the CVS directories)
# in front, change that line to this:

fpath=( ~/.zfuncs ~/.zfuncs/VCS_Info/**/*~*/(CVS)#(/) $fpath )

# The weirdly looking pattern requires the `extended_glob' option to be
# active, so make sure it is.
#
# Step three: "Restart Z shell"
# A simple
#  % exec zsh
# gets you there. You should be all set now. Have fun.
