#
# cd option
#
setopt AUTOCD            \
       AUTO_PUSHD        \
       CHASE_DOTS        \
       CHASE_LINKS       \
       POSIX_CD          \
       PUSHD_IGNORE_DUPS \
       PUSHD_MINUS       \
       PUSHD_SILENT      \
       PUSHD_TO_HOME     \
       CDABLE_VARS       

#
# Completion Options
#

setopt ALWAYS_LAST_PROMPT \
       ALWAYS_TO_END      \
       AUTO_LIST          \
       AUTO_MENU          \
       AUTO_NAME_DIRS     \
       AUTO_PARAM_KEYS    \
       AUTO_PARAM_SLASH   \
       AUTO_REMOVE_SLASH  \
       BASH_AUTO_LIST     \
       COMPLETE_ALIASES   \
       COMPLETE_IN_WORD   \
       GLOB_COMPLETE      \
       HASH_LIST_ALL      \
       LIST_AMBIGUOUS     \
       NO_LIST_BEEP       \
       LIST_PACKED        \
       LIST_ROWS_FIRST    \
       LIST_TYPES         \
       MENU_COMPLETE      \
       REC_EXACT

#
# Expansion and Globbing
#

setopt EXTENDED_GLOB

#
# History
#

setopt APPEND_HISTORY         \
       BANG_HIST              \
    NO_EXTENDED_HISTORY       \
       HIST_ALLOW_CLOBBER     \
    NO_HIST_BEEP              \
       HIST_EXPIRE_DUPS_FIRST \
       HIST_FCNTL_LOCK        \
       HIST_FIND_NO_DUPS      \
       HIST_IGNORE_ALL_DUPS   \
       HIST_IGNORE_DUPS       \
       HIST_IGNORE_SPACE      \
    NO_HIST_LEX_WORDS         \
       HIST_NO_FUNCTIONS      \
       HIST_NO_STORE          \
       HIST_REDUCE_BLANKS     \
       HIST_SAVE_BY_COPY      \
       HIST_SAVE_NO_DUPS      \
       HIST_VERIFY            \
       INC_APPEND_HISTORY     \
       SHARE_HISTORY

#
# Input/Output
# 

setopt ALIASES              \
       CLOBBER              \
       CORRECT              \
       CORRECT_ALL          \
       FLOW_CONTROL         \
       INTERACTIVE_COMMENTS \
       HASH_CMDS            \
       HASH_DIRS            \
    NO_MAIL_WARNING         \
       PATH_DIRS            \
       PATH_SCRIPT          \
    NO_PRINT_EIGHT_BIT      \
       PRINT_EXIT_VALUE     \
    NO_RC_QUOTES            \
    NO_RM_STAR_SILENT       \
       RM_STAR_WAIT         \
       SHORT_LOOPS

#
# Job Control
#

setopt AUTO_CONTINUE  \
       AUTO_RESUME    \
       BG_NICE        \
       CHECK_JOBS     \
       HUP            \
       LONG_LIST_JOBS \
       MONITOR        \
       NOTIFY

setopt listtypes               # show types in completion
setopt no_flow_control         # Turns off C-S/C-Q flow control

# (needed by the vcs_info module, i.e. ${vcs_info_msg_N_})
[[ -e $(alias run-help)  ]] && unalias run-help
autoload run-help

#   Inline completion
set always_to_end

setopt prompt_subst
autoload -U promptinit

# color ls
eval `dircolors -b`

# limits {{{
 ######################################################################
 # Limits
 ######################################################################

# ulimit -u 1024
 # ulimit -v `cat /proc/meminfo | head -1 | tr -s ' ' | cut -d' ' -f2`
# ulimit -v ${${(s. .)${(M)${(f)"$(</proc/meminfo)"}##MemTotal: *}}[2]}

# }}}
