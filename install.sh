#!/bin/sh

dir=`pwd` 
owner=$(stat -c '%U' $(pwd))

apt install exuberant-ctags
git clone https://github.com/vim-scripts/taglist.vim.git 

chown -R $owner taglist.vim
chgrp -R $owner taglist.vim

ln -sf $dir/taglist.vim/doc/ ~/.vim/
ln -sf $dir/taglist.vim/plugin/ ~/.vim/

chown -R $owner ~/.vim/
chgrp -R $owner ~/.vim/
