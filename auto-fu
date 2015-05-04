zstyle ':auto-fu:highlight' input bold
zstyle ':auto-fu:highlight' completion fg=black,bold
zstyle ':auto-fu:highlight' completion/one fg=white,bold,underline
zstyle ':auto-fu:var' postdisplay ''
zstyle ':auto-fu:var' track-keymap-skip opp
zstyle ':auto-fu:var' enable all
zstyle ':auto-fu:var' disable magic-space
zstyle ':auto-fu:var' autoable-function/skipwords \
    "('|$'|\")*"
zstyle ':auto-fu:var' autoable-function/skiplbuffers \
    'rm -[![:blank:]]#'
zstyle ':auto-fu:var' autoable-function/skiplines \
    'yaourt *'  'kill *' 'systemctl [[:print:]]# *' \
    'mv [[:print:]]# *' 'rm *'

zle-line-init () {
    auto-fu-init
}

toggle-auto-fu() {
    if (( $+disable_auto_fu )); then
        zle -N zle-line-init
        unset disable_auto_fu
        auto-fu-init
    else
        zle -D zle-line-init
        auto-fu-deactivate
        disable_auto_fu=1
    fi
}
zle -N toggle-auto-fu

bindkey -M viins '^O' toggle-auto-fu
bindkey -M afu '^O' toggle-auto-fu
bindkey -M afu '^T' fzf-file-widget
bindkey -M afu '^L' fzf-cd-widget
bindkey -M afu '^H' fzf-history-widget
bindkey -M afu '\e' afu+vi-cmd-mode
bindkey -M afu-vicmd 'k' history-substring-search-up
bindkey -M afu-vicmd 'j' history-substring-search-down
bindkey -M afu-vicmd 'gh' vi-beginning-of-line
bindkey -M afu-vicmd 'gl' vi-end-of-line
bindkey -M afu-vicmd 'cc' vi-change-whole-line
