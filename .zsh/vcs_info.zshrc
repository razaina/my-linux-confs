# -*- Mode: SH -*-

zstyle ':vcs_info:*' enable hg git bzr svn
zstyle ':vcs_info:(hg*|git*):*' get-revision true
zstyle ':vcs_info:(hg*|git*):*' check-for-changes true

# rev+changes branch misc
zstyle ':vcs_info:hg*' formats "(%s)[%i%u %b %m]"
zstyle ':vcs_info:hg*' actionformats "(%s|%a)[%i%u %b %m]"

# hash changes branch misc
zstyle ':vcs_info:git*' formats "(%s)[%12.12i %u %b %m]"
zstyle ':vcs_info:git*' actionformats "(%s|%a)[%12.12i %u %b %m]"

zstyle ':vcs_info:hg*:netbeans' use-simple true

zstyle ':vcs_info:hg*:*' get-bookmarks true

zstyle ':vcs_info:hg*:*' get-mq true
zstyle ':vcs_info:hg*:*' get-unapplied true
zstyle ':vcs_info:hg*:*' patch-format "mq(%g):%n/%c %p"
zstyle ':vcs_info:hg*:*' nopatch-format "mq(%g):%n/%c %p"

zstyle ':vcs_info:hg*:*' unstagedstr "+"
zstyle ':vcs_info:hg*:*' hgrevformat "%r" # only show local rev.
zstyle ':vcs_info:hg*:*' branchformat "%b" # only show branch

zstyle ':vcs_info:hg*+set-message:*' hooks hg-storerev hg-branchhead

### Store the localrev and global hash for use in other hooks
function +vi-hg-storerev() {
    user_data[localrev]=${hook_com[localrev]}
    user_data[hash]=${hook_com[hash]}
}

### Show marker when the working directory is not on a branch head
# This may indicate that running `hg up` will do something
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
            hook_com[revision]="${c4}^${c2}${hook_com[revision]}"
        fi
    fi
}