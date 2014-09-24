swiki() {
    if [ $# = 0 ]; then
        name="test"
    else
        name=$1
    fi
    last_scrot=$HOME/Dropbox/vimwiki/public/html/assets/image/$name.png
    scrot -s $last_scrot
}

sblog() {
    if [ $# = 0 ]; then
        name="test"
    else
        name=$1
    fi
    last_scrot=$HOME/workspace/html/blog-raw/assets/images/article/$1.png
    scrot -s $last_scrot
}

sprev() {
    if (( $+last_scrot )); then
        xdg-open $last_scrot
    else
        echo "run swiki or sblog first!"
    fi
}

sundo() {
    rm $last_scrot -f
    unset last_scrot
}
