# ftags - search ctags
ftags() {
    local line
    [ -e tags ] &&
        line=$(grep -v "^!" tags | cut -f1-3 | cut -c1-80 | fzf --nth=1) &&
        $EDITOR $(cut -f2 <<< "$line")
}

# fq1 [QUERY]
# - Immediately select the file when there's only one match.
#   If not, start the fuzzy finder as usual.
fq1() {
    local lines
    lines=$(fzf --filter="$1" --no-sort)
    if [ -z "$lines" ]; then
        return 1
    elif [ $(wc -l <<< "$lines") -eq 1 ]; then
        echo "$lines"
    else
        echo "$lines" | fzf --query="$1"
    fi
}

# fe [QUERY]
# - Open the selected file with the default editor
#   (Bypass fuzzy finder when there's only one match)
fe() {
    local file
    file=$(fq1 "$1") && ${EDITOR:-vim} "$file"
}

# vfg [QUERY]
# - search gtags and open in vim
vfg() {
    local words
    words=( $(global -x "$@" | fzf) )
    vim ${words[3]} +${words[2]}
}

# vlocate [QUERY]
# - open located file in vim
vlocate() {
    vim `locate $@ | fzf`
}

xlocate() {
    xdg-open `locate $@ | fzf`
}

# Key bindings
# ------------
# CTRL-T - Paste the selected file path(s) into the command line
__fsel() {
    set -o nonomatch
    command find * -path '*/\.*' -prune \
        -o -type f -print \
        -o -type d -print \
        -o -type l -print 2> /dev/null | fzf -m | while read item; do
    printf '%q ' "$item"
done
echo
}

if [[ $- =~ i ]]; then

    if [ -n "$TMUX_PANE" -a ${FZF_TMUX:-1} -ne 0 -a ${LINES:-40} -gt 15 ]; then
        fzf-file-widget() {
            local height
            height=${FZF_TMUX_HEIGHT:-40%}
            if [[ $height =~ %$ ]]; then
                height="-p ${height%\%}"
            else
                height="-l $height"
            fi
            tmux split-window $height "zsh -c 'source ~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-farseer90718-SLASH-zsh-funcs.git/fzf.zsh; tmux send-keys -t $TMUX_PANE \"\$(__fsel)\"'"
        }
    else
        fzf-file-widget() {
            LBUFFER="${LBUFFER}$(__fsel)"
            zle redisplay
        }
    fi

    # ALT-C - cd into the selected directory
    fzf-cd-widget() {
        cd "${$(set -o nonomatch; command find -L * -path '*/\.*' -prune \
            -o -type d -print 2> /dev/null | fzf):-.}"
        zle reset-prompt
    }

    # CTRL-R - Paste the selected command from history into the command line
    fzf-history-widget() {
        LBUFFER=$(fc -l 1 | fzf +s +m -n2..,.. | sed "s/ *[0-9*]* *//")
        zle redisplay
    }

fi
