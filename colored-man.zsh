man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[0;31m") \
        LESS_TERMCAP_md=$(printf "\e[0;32m") \
        LESS_TERMCAP_me=$(printf "\e[0;34m") \
        LESS_TERMCAP_se=$(printf "\e[1;34m") \
        LESS_TERMCAP_so=$(printf "\e[0;36m") \
        LESS_TERMCAP_ue=$(printf "\e[0;34m") \
        LESS_TERMCAP_us=$(printf "\e[0;35m") \
        man "$@"
}
