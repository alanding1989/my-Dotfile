#! /usr/bin/env bash

read -rp "Install or update ->: [i/u]" bb

if [ "$bb" = i ]; then
  echo "start installation"
elif [ "$bb" = u ]; then
  echo "update now"
else
  echo "invalid input!!"
  exit
fi

mydotfile=$(cd "$(dirname "$0")"; cd ..; pwd)


#--------------------------------------------------------------------------------
# Add source and Remove some useless software
#--------------------------------------------------------------------------------
if [ "$bb" = i ]; then
  add-apt-repository ppa:daniruiz/flat-remix
  add-apt-repository ppa:noobslab/macbuntu
  apt-add-repository ppa:zanchey/asciinema

  apt-get remove unity-webapps-common thunderbird totem rhythmbox empathy \
    brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese onboard \
    transmission-common gnome-orca webbrowser-app gnome-sudoku deja-dup\
    landscape-client-ui-install libreoffice-common firefox*
fi


#--------------------------------------------------------------------------------
# Install from ubuntu source 
#--------------------------------------------------------------------------------
apt-get update
apt-get install zsh vim git git-extras tig tmux guake albert gdebi curl jq \
  tsocks goldendict urlview xclip ripgrep silversearcher-ag fcitx \
  xserver-xorg-input-synaptics synaptic openssh-server asciinema \
  build-essential gcc-8 g++-8 global texinfo

# system theme
apt-get install flat-remix-gnome flat-remix gnome-tweaks gnome-shell-extension-top-icons-plus acpi

sudo ln -s /bin/bash /bin/sh -f


#--------------------------------------------------------------------------------
# Install from web
#--------------------------------------------------------------------------------
#@ oh-my-zsh
if [ ! -e "$HOME/.oh-my-zsh" ]; then
  wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
  # zsh plugins
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
  git clone git://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  git clone https://github.com/paulirish/git-open.git \
    "$ZSH_CUSTOM/plugins/git-open"
  if [ -e "$HOME/.zsh.pre-oh-my-zsh" ]; then
    mv ~/.zsh.pre-oh-my-zsh ~/.zshrc
  fi
fi

if [ "$bb" = i ]; then
  sudo chsh -s /bin/zsh root
  zsh
  cp "$mydotfile/linux/alan-root/.*" "$HOME" && cp "$mydotfile/linux/alan-root/*"  "/home/alanding"

  #@ install fonts
  cp -r "$mydotfile/fonts/powerline" /usr/share/fonts
  fc-cache -vf

  #@ icons
  cp "$mydotfile/system-theme/icons/*.desktop" /usr/share/applications

  # ssh
  #@ TODO add privatekey to github
  rm ~/.ssh && ssh localhost || cd ~/.ssh && ssh-keygen -t rsa && cat ./id_rsa.pub >> ./authorized_keys

  # 版本修改 gcc and g++
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 60
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 40
  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 60
  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 40

  source "$HOME/.zshrc"
fi

#@ SpaceVim
if [ ! -e "$HOME/.SpaceVim" ]; then
  sh "$mydotfile/ide-config/vim-install/linux-MyVim-install.sh"
fi


# --------------------------------------------------------------------------------
# Lang install 
# --------------------------------------------------------------------------------
vimroot=/home/alanding/.SpaceVim.d

declare -a lang
lang=(cpp go lua nodejs python)
for lang in ${lang[*]}; do
  sh "$vimroot/extools/lang-install/$lang"
done


#--------------------------------------------------------------------------------
# Install from disk  
#--------------------------------------------------------------------------------
#@ Deepin-wine
if [ ! -x "/usr/bin/deepin-wine" ]; then
  cpath=$(pwd)
  sh /mnt/fun+downloads/linux系统安装/dayly-software/deepin-wine-ubuntu-master/install.sh
  # source website
  # http://www.wps.cn/product/wpslinux/#
  # https://pinyin.sogou.com/linux/?r=pinyin
  # https://music.163.com/#/download
  # http://www.xm1math.net/texmaker/download.html
  # https://www.xmind.net/download/xmind8
  # https://github.com/wszqkzqk/deepin-wine-ubuntu
  cd /mnt/fun+downloads/linux系统安装/dayly-software || return

  #@ Google
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

  #@ rg search
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.12.0/ripgrep_0.12.0_amd64.deb

  #@ vscode fd
  cd /mnt/fun+downloads/linux系统安装/code-software || return
  dpkg -i ./*.deb

  # tex 换源
  tlmgr option repository http://mirrors.ustc.edu.cn/CTAN/systems/texlive/tlnet
  cd "$cpath" || return
fi

# fix dependencies
apt-get --fix-broken install
apt-get autoclean && apt-get autoremove && apt-get clean


#--------------------------------------------------------------------------------
# Nvidia install
#--------------------------------------------------------------------------------
if ! lsmod | grep nouveau; then
  echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
  update-initramfs -u
fi

if [ -z "$(nvidia-smi)" ]; then
  read -pr "Confirm to remove Nvidia? [y/n] ->:" cc
  if [ "$cc" = y ]; then
    apt-get remove --purge nvidia*
    cd /mnt/fun+downloads/linux系统安装/code-software/system-util || return
    chmod +x ./*.run | ./NVIDIA-Linux-x86_6<4-410.78.run
  fi
fi

