#!/usr/bin/env bash

# ================================================================================
#  File Name    : vim-install/linux/my-config-install.sh
#  Author       : AlanDing
#  Created Time : Thu 18 Apr 2019 10:40:27 PM CST
# ================================================================================


git clone git@github.com:alanding1989/SpaceVim.git "/home/alanding/.SpaceVim"
git clone git@github.com:alanding1989/my-Vim.git "/home/alanding/.SpaceVim.d"

if [ "$(whoami)" = 'root' ] && [ ! -e "/root/.SpaceVim" ]; then
  ln -s /home/alanding/.SpaceVim    /root/.SpaceVim
  ln -s /home/alanding/.SpaceVim.d  /root/.SpaceVim.d
fi

ln -s "$HOME/.SpaceVim" "$HOME/config/nvim"

if [ ! -e "/home/alanding/.vim" ]; then
  ln -s /home/alanding/.SpaceVim.d  /home/alanding/.vim
fi

