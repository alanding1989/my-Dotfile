# ================================================================================
#  File Name    : vim-install/linux/my-config-install.sh
#  Author       : AlanDing
#  mail         :
#  Created Time : Thu 18 Apr 2019 10:40:27 PM CST
# ================================================================================
#!/usr/bin/env bash


git clone git@github.com:alanding1989/SpaceVim.git "$HOME/.SpaceVim"
git clone git@github.com:alanding1989/my-Vim.git "$HOME/.vim"

ln -s "$HOME/.SpaceVim" "$HOME/config/nvim"
ln -s "$HOME/.vim" "$HOME/.SpaceVim.d"
