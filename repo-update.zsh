function src-update () {
    eval currentpath=$(pwd)
    eval gitpath=$(realpath $1)
    for i in $(find $gitpath -maxdepth 1 -type d)
        do
            cd $i
            eval repo=$(echo $i | gawk -F "/" '{print $NF}')
            if [[ -d ".git" ]]; then
                print "\n\33[32m****************\33[34mpulling $repo\33[32m****************\33[0m\n"
                git pull && git rebase
            elif [[ -d ".hg" ]]; then
                print "\n\33[32m****************\33[34mpulling $repo\33[32m****************\33[0m\n"
                hg pull
                print "\n\33[32m****************\33[34mupdating $repo\33[32m****************\33[0m\n"
                hg update
            elif [[ -d ".svn" ]]; then
                print "\n\33[32m****************\33[34mupdating $repo\33[32m****************\33[0m\n"
                svn update
            elif [[ -d "CVS" ]] ; then
                print "\n\33[32m****************\33[34mupdating $repo\33[32m****************\33[0m\n"
                cvs update
            fi
        done
        cd $currentpath
}

function repo-update {
    cd $HOME
    print "\n\33[32m*************************\33[34mgit submodule\33[32m**********************************\33[0m\n"
    git submodule foreach 'git pull && git rebase'
    print "\n\33[32m*************************\33[34mnpm\33[32m**********************************\33[0m\n"
    sudo npm update -g
    print "\n\33[32m*************************\33[34mgem\33[32m**********************************\33[0m\n"
    gem update
    gem cleanup
    # print "\n\33[32m*************************\33[34mpear\33[32m*********************************\33[0m\n"
    # sudo pear upgrade
    print "\n\33[32m**************************************************************\33[0m\n"
    antigen update
    antigen selfupdate
    if [[ -d "$HOME/src" ]]; then
        src-update $HOME/src
    else
        echo "$HOME/src not exist"
    fi
}
