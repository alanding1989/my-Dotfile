#! /usr/bin/env bash

set -e

read -rp "Install or update ->: [i/u]" bb

if [ "$bb" = i ]; then
  echo "start installation"
elif [ "$bb" = u ]; then
  echo "update now"
else
  echo "invalid input!!"
  exit 1
fi

mydotfile=$(cd "$(dirname "$0")"; cd ..; pwd)

[ -x "zsh" ] && zsh


#--------------------------------------------------------------------------------
# Installation preparation 
#----------------------------------------------------------------------------- # {{{

preparation() {
  sudo add-apt-repository ppa:daniruiz/flat-remix
  sudo add-apt-repository ppa:noobslab/macbuntu
  sudo apt-add-repository ppa:zanchey/asciinema
  sudo add-apt-repository ppa:jonathonf/vim
  sudo add-apt-repository ppa:kelleyk/emacs -y
  apt-get update

  sudo ln -s -f /bin/bash /bin/sh
  sudo ln -s -f /bin/bash /usr/bin/sh#
  sudo apt-get install git zsh
  sudo chsh -s /bin/zsh root
  cp -r "$mydotfile/linux/alan-root/.zshrc" "/root"
}
# }}}


#--------------------------------------------------------------------------------
# Add source and Remove some useless software
#----------------------------------------------------------------------------- # {{{
remove_useless() {
  if [ "$bb" = i ]; then
    apt-get remove unity-webapps-common thunderbird totem rhythmbox empathy \
      brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese onboard \
      transmission-common gnome-orca webbrowser-app gnome-sudoku deja-dup\
      landscape-client-ui-install libreoffice-common firefox*
  fi
}
# }}}


#--------------------------------------------------------------------------------
# Install from ubuntu source 
#---------------------------------------------------------------------------- # {{{
install_apps() {
  # build-tools
  apt-get install gcc-8 g++-8 build-essential texinfo autoconf automake pkg-config bear 

  # deps
  apt-get install \
    libncurses5-dev libgtk-3-dev libgtk2.0-dev libatlas-base-dev\
    libjpeg-dev libpng-dev libtiff-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libaudit-dev libslang2-dev libelf-dev systemtap-sdt-dev \
    pcre2-utils libpcre2-dev \
    libperl-dev python3-dev

  # cli
  apt-get install shellcheck cppcheck global pandoc \
    net-tools sysstat htop 
   # c++ 内存泄漏排查工具
   # valgrind valgrind-dbg valgrind-mpi

  apt-get install \
    vim emacs26 guake zsh git-extras tig tmux curl tree urlview mysql-workbench-community \
    asciinema openssh-server unrar rar unzip xclip acpi tsocks convmv jq

    # silversearcher-ag

  # gui
  apt-get install \
    okular kchmviewer qbittorrent goldendict gimp vlc fcitx fcitx-googlepinyin \
    synaptic xserver-xorg-input-synaptics gdebi 
    # albert

  # system theme
  apt-get install \
    flat-remix-gnome flat-remix \
    gnome-tweaks gnome-shell-extension-top-icons-plus nyancat
  # 打开软件商城，安装附加组件
  # user themes
  # dash to dock
  # Hide Top Bar

  apt-get upgrade

}
# }}}


#--------------------------------------------------------------------------------
# Install ZSH, Tmux, Vim, fonts, 
#----------------------------------------------------------------------------- # {{{
install_zsh_fonts() {
  #@ oh-my-zsh
  if [ ! -e "$HOME/.oh-my-zsh" ]; then
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
    # zsh plugins
    git clone https://github.com/esc/conda-zsh-completion              "$ZSH_CUSTOM/plugins/conda-completions"
    git clone https://github.com/paulirish/git-open.git                "$ZSH_CUSTOM/plugins/git-open"
    git clone git@github.com:gradle/gradle-completion.git              "$ZSH_CUSTOM/plugins/gradle-completion"
    git clone git://github.com/zsh-users/zsh-autosuggestions           "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

    if [ -e "$HOME/.zsh.pre-oh-my-zsh" ]; then
      mv "$HOME/.zsh.pre-oh-my-zsh" "$HOME/.zshrc"
    fi
    if [ -e "/root/.oh-my-zsh" ]; then
      rm -r /root/.oh-my-zsh && cp -r /home/alanding/.oh-my-zsh /root/
    fi
  fi

  #@TODO tmux 启动后安装插件

  #@ install fonts
  sudo cp -r "$mydotfile/fonts/powerline" /usr/share/fonts
  sudo fc-cache -vf

  # ssh
  # rm $HOME/.ssh && ssh localhost && cd ~/.ssh && ssh-keygen -t rsa && cat ./id_rsa.pub >> ./authorized_keys
  ssh-keygen -f "/home/alanding/.ssh/known_hosts" -R "localhost"
  ssh-keygen -f "/home/alanding/.ssh/known_hosts" -R "0.0.0.0"

  # 版本修改 gcc and g++
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 60
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 50
  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 60
  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 50
  # update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 40
  # update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 40

  update-alternatives --config gcc
  update-alternatives --config g++
}


install_vim() {
  #@ SpaceVim and Myconfig
  if [ ! -e "$HOME/.SpaceVim" ]; then
    sh "$mydotfile/ide-config/vim-install/linux-MyVim-install.sh"
  fi
}
# }}}


# --------------------------------------------------------------------------------
# Lang install 
# ----------------------------------------------------------------------------- # {{{
lang_install() {
  local vimroot=/home/alanding/.SpaceVim.d
  declare -a lang=(cpp rust go lua nodejs python)

  for lang in "${lang[@]}"; do
    [ -e "$vimroot/lib/lang-install/$lang" ] && sh "$vimroot/lib/lang-install/$lang"
  done

  if [ -x cargo ]; then
    [ -x rg ] || cargo install ripgrep
  else
    printf "You need to install cargo!" && exit 1
  fi  
}
# }}}


#--------------------------------------------------------------------------------
# Install from disk  
#----------------------------------------------------------------------------- # {{{
install_wine_code_google() {
  #@ Deepin-wine
  if [ ! -x "/usr/bin/deepin-wine" ]; then
    local cpath
    cpath=$(pwd)
    # sh /mnt/fun+downloads/linux系统安装/daily-software/deepin-wine-env/install.sh

    # @@ app website
    # http://www.wps.cn/product/wpslinux/#
    # https://pinyin.sogou.com/linux/?r=pinyin
    # https://music.163.com/#/download
    # http://www.xm1math.net/texmaker/download.html
    # https://www.xmind.net/download/xmind8
    # https://github.com/wszqkzqk/deepin-wine-ubuntu

    #@ Google
    cd /mnt/fun+downloads/linux系统安装/daily-software || return
    rm -f google-chrome-stable_current_amd64.deb
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    dpkg -i ./*.deb

    cd /mnt/fun+downloads/linux系统安装/code-software/devtools || return
    dpkg -i ./*.deb

    local chromedriver=/mnt/fun+downloads/linux系统安装/code-software/devtools/chromedriver
    [ -e $chromedriver ] || echo "Please download chromedriver !" | exit 1

    # tex 换源
    tlmgr option repository http://mirrors.ustc.edu.cn/CTAN/systems/texlive/tlnet
    cd "$cpath" || return
  fi

  # fix dependencies
  apt-get --fix-broken install
  apt-get autoclean && apt-get autoremove && apt-get clean

  # FIXME:
  zsh
  #@ icons
  cp -r "$mydotfile/system-theme/wallpaper" /home/alanding/Pictures \
    && $HOME/Pictures/wallpaper $HOME/Pictures/壁纸

  cp -r "$mydotfile/linux/alan-root/.*" /root
}


install_databases() {
  cp -r /mnt/fun+downloads/my-Dotfile/linux/alan-root/etc  /etc
  cd /mnt/fun+downloads/my-Dotfile/linux/work-tools/database || return
  sh ./mysql.sh
  sh ./redis.sh
  sh ./mongodb.sh
}
# }}}


#--------------------------------------------------------------------------------
# Nvidia install
#----------------------------------------------------------------------------- # {{{
install_nvidia() {
  if lsmod | grep nouveau; then
    echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
    update-initramfs -u
    # sudo reboot
  fi

  nvidia-smi || read -rp "Confirm to remove Nvidia? [y/n] ->:" cc
  if [[ "$cc" = y ]]; then
    apt-get remove --purge nvidia*
    cd /mnt/fun+downloads/linux系统安装/code-software/system-util || return
    chmod +x ./*.run 
    echo 'Installation must run in shell ! can`t in a subprocess'
  fi
}

# install_yarnpkg() {
  # ln -sf /opt/lang-tools/nvm/versions/node/v11.9.0/bin/node /usr/bin/nodejs
  # ln -sf /opt/lang-tools/nvm/versions/node/v11.9.0/bin/node /usr/bin/node
# }
# }}}


#--------------------------------------------------------------------------------
# load
#----------------------------------------------------------------------------- # {{{
preparation
remove_useless
install_apps
# install_zsh_fonts
# install_vim
# install_yarnpkg
# lang_install
# install_wine_code_google
# install_nvidia

# }}}

