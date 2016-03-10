function cprint {
    print "\n\33[32m"
    printf "=%.0s" {1..$((25-$#1/2))}
    printf "\33[3$2m $1 \33[32m"
    printf "=%.0s" {1..$((26-$#1/2-$#1%2))}
    print "\33[0m\n"
}

function src-update () {
    eval currentpath=$(pwd)
    eval gitpath=$(realpath $1)
    for i in $(find $gitpath -maxdepth 1 -type d)
        do
            cd $i
            eval repo=$(echo $i | gawk -F "/" '{print $NF}')
            if [[ -d ".git" ]]; then
                cprint "pulling $repo" 4
                git pull && git rebase
            elif [[ -d ".hg" ]]; then
                cprint "pulling $repo" 4
                hg pull
                cprint "upding $repo" 4
                hg update
            elif [[ -d ".svn" ]]; then
                cprint "upding $repo" 4
                svn update
            elif [[ -d "CVS" ]] ; then
                cprint "upding $repo" 4
                cvs update
            fi
        done
        cd $currentpath
}

function repo-update {
    cd $HOME
    cprint "git submodule" 3
    git submodule foreach 'git pull && git rebase'
    cprint "tmux plugins" 3
    src-update ~/.tmux/plugins
    cprint "npm" 1
    sudo npm update -g
    cprint "gem" 1
    gem update
    sudo gem cleanup
    gem cleanup
    # cprint "pear" 1
    # sudo pear upgrade
    cprint "antigen" 3
    antigen update
    antigen selfupdate
    if [[ -d "$HOME/src" ]]; then
        src-update $HOME/src
    else
        echo "$HOME/src not exist"
    fi
}
