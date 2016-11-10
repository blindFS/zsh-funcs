fpath+="`dirname $0`/src"

# ls color solarized
autoload -U colors && colors
eval `dircolors ~/.dircolors`

zstyle ':completion::complete:*' use-cache  1
zstyle ':completion::complete:*' cache-path ~/tmp/.zcache
zstyle ':completion:*:cd:*'      tag-order  local-directories directory-stack path-directories

if [[ "$CASE_SENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
    if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
    else
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
    fi
fi
set CASE_SENSITIVE HYPHEN_INSENSITIVE

zstyle ':completion:*:*:*:*:*'            menu             select
#
zstyle ':completion:*:killall:*'          command          'ps -u $USER -o cmd'
zstyle ':completion:*:*:*:*:processes'    command          "ps -u $USER -o pid,user,comm -w -w"

zstyle ':completion:*:options'            description      'yes'
zstyle ':completion:*:options'            auto-description '%d'
zstyle ':completion:*:descriptions'       format           $' \e[30;42m %d \e[0m\e[32m\e[0m'
zstyle ':completion:*:messages'           format           $' \e[30;45m %d \e[0m\e[35m\e[0m'
zstyle ':completion:*:warnings'           format           $' \e[30;41m No Match Found \e[0m\e[31m\e[0m'
