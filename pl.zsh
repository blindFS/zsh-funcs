prompt_proxy () {
    if (($+http_proxy)); then
        echo -n " 🌎 "
    fi
}

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode root_indicator context dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status proxy vcs)
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\n"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$(prompt_os_icon left 1 && left_prompt_end)"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_STATUS_VERBOSE=false
export DEFAULT_USER="$USER"

# Vi-Mode
POWERLEVEL9K_VI_INSERT_MODE_STRING="✎"
POWERLEVEL9K_VI_COMMAND_MODE_STRING=""

function zle-line-init {
    powerlevel9k_prepare_prompts
    if (( ${+terminfo[smkx]} )); then
        printf '%s' ${terminfo[smkx]}
    fi
    zle reset-prompt
    zle -R
}

function zle-line-finish {
    powerlevel9k_prepare_prompts
    if (( ${+terminfo[rmkx]} )); then
        printf '%s' ${terminfo[rmkx]}
    fi
    zle reset-prompt
    zle -R
}

function zle-keymap-select {
    powerlevel9k_prepare_prompts
    zle reset-prompt
    zle -R
}

zle -N zle-line-init
# zle -N zle-line-finish
zle -N zle-keymap-select
