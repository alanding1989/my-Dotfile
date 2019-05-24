#!/usr/bin/env bash

# ================================================================================
#  File Name    : vim-install/linux/my-config-install.sh
#  Author       : AlanDing
#  Created Time : Thu 18 Apr 2019 10:40:27 PM CST
# ================================================================================


git clone git@github.com:alanding1989/SpaceVim.git "$HOME/.SpaceVim"
git clone git@github.com:alanding1989/my-Vim.git "$HOME/.SpaceVim.d"

ln -s "$HOME/.SpaceVim" "$HOME/config/nvim"
ln -s "$HOME/.SpaceVim.d" "$HOME/.vim"
