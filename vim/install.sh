#!/bin/bash

# check permission
ins_repo_to(){
    ret=$(ls $2)
    if [[ -z "$ret" ]]; then
        echo "Installing $1 to $2"
        git clone https://github.com/$1.git $2 > /dev/null
    else
        echo "$2 exist, updating"
        pushd $2 > /dev/null
        git pull
        popd > /dev/pull
    fi
}

if [[ "$UID" != "0" ]]; then
    echo "/===================  ERR  ================\\"
    echo "|                                          |"
    echo "| Should be executed under root permission |"
    echo "|                                          |"
    echo "\\==========================================/"
    exit -1
fi

echo "building up vim environment"

cd $(dirname $0)
pwd=$(pwd) 
owner=$(stat -c '%U' $(pwd))
home="/home/${owner}"

echo "==== INFO ======"
echo "Dir: ${pwd}"
echo "Owner: ${owner}"
echo "Home: ${home}"
echo "================"

# set .vimrc
echo "[INFO] vimrc setup"
echo  ${pwd}
ln -sf ${pwd}/.vimrc ${home}/
root_list="${home}/.vimrc"

# clone taglist
apt update
apt install exuberant-ctags > /dev/null
ins_repo_to vim-scripts/taglist.vim ${pwd}/taglist.vim
root_list="${root_list} ${pwd}/taglist.vim"
echo 

# install taglist
ln -sf ${pwd}/taglist.vim/doc/taglist.txt  ~/.vim/doc/
ln -sf ${pwd}/taglist.vim/plugin/taglist.vim ~/.vim/plugin/
root_list="${root_list} ${home}/.vim/"

# install Vundle (vim package manager)
ins_repo_to VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall #inteall plugins 
pushd ~/.vim/bundle/Vundle.vim/YouCompleteMe/ > /dev/null
./install --clang-completer
./install --rust-completer

# ================ For Rust ================ 

# ========================================== 

echo "root list: " ${root_list}
for i in ${root_list}; do
    echo "reset ownership: ${i}"
    chown -R $owner $i
    chgrp -R $owner $i
done
