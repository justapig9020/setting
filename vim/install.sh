#!/bin/bash

# check permission

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
dir=$(pwd) 
owner=$(stat -c '%U' $(pwd))
home="/home/${owner}"

echo "Dir: ${dir}"
echo "Owner: ${owner}"
echo "Home: ${home}"

# set .vimrc
echo  ${dir}
ln -sf ${dir}/.vimrc ${home}/
root_list="${home}/.vimrc"
echo "[INFO] vimrc setuped"

# clone taglist
apt update
apt install exuberant-ctags > /dev/null
rm -rf ./taglist.vim
git clone https://github.com/vim-scripts/taglist.vim.git > /dev/null
root_list="${root_list} ${dir}/taglist.vim"
echo 

# install taglist
ln -sf ${dir}/taglist.vim/doc/taglist.txt  ~/.vim/doc/
ln -sf ${dir}/taglist.vim/plugin/taglist.vim ~/.vim/plugin/
root_list="${root_list} ${home}/.vim/"

# install Vundle (vim package manager)
rm -rf ~/.vim/bundle/Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim > /dev/null
vim +PluginInstall +qall #inteall plugins 

# 
echo "root list: " ${root_list}
for i in ${root_list}; do
    echo "reset ownership: ${i}"
    chown -R $owner $i
    chgrp -R $owner $i
done
