swiki() {
    last_scrot=$HOME/Dropbox/vimwiki/html/assets/image/$1.png
    scrot -s $last_scrot
}

sblog() {
    last_scrot=$HOME/workspace/html/blog-raw/assets/images/article/$1.png
    scrot -s $last_scrot
}

sprev() {
    if [ -f $last_scrot ]; then
        xdg-open $last_scrot
    else
        echo "run swiki or sblog first!"
    fi
}

sundo() {
    rm $last_scrot -f
}
