mwiki() {
    if [ $# = 0 ]; then
        name="test"
    else
        name=$1
    fi
    last_maim=$HOME/Dropbox/Public/html/assets/image/$name.png
    maim -s $last_maim
}

mblog() {
    if [ $# = 0 ]; then
        name="test"
    else
        name=$1
    fi
    last_maim=$HOME/workspace/html/blog-raw/assets/images/article/$1.png
    maim -s $last_maim
}

mprev() {
    if (( $+last_maim )); then
        xdg-open $last_maim
    else
        echo "run swiki or sblog first!"
    fi
}

mundo() {
    rm $last_maim -f
    unset last_maim
}
