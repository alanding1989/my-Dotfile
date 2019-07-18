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


preparation() {
  add-apt-repository ppa:daniruiz/flat-remix
  add-apt-repository ppa:noobslab/macbuntu
  apt-add-repository ppa:zanchey/asciinema
  apt-get update

  sudo ln -s /bin/bash /bin/sh -f
  sudo apt-get install git zsh
  sudo chsh -s /bin/zsh root
  cp -r "$mydotfile/linux/alan-root/.zshrc" "/root"
}


remove_useless() {
  #--------------------------------------------------------------------------------
  # Add source and Remove some useless software
  #--------------------------------------------------------------------------------
  if [ "$bb" = i ]; then
    apt-get remove unity-webapps-common thunderbird totem rhythmbox empathy \
      brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese onboard \
      transmission-common gnome-orca webbrowser-app gnome-sudoku deja-dup\
      landscape-client-ui-install libreoffice-common firefox*
  fi
}

install_apps() {
  #--------------------------------------------------------------------------------
  # Install from ubuntu source 
  #--------------------------------------------------------------------------------

  apt-get install zsh  git-extras tig tmux guake albert gdebi curl jq \
    tsocks goldendict urlview xclip silversearcher-ag fcitx \
    xserver-xorg-input-synaptics synaptic openssh-server asciinema \
    build-essential gcc-8 g++-8 global texinfo

  # system theme
  apt-get install flat-remix-gnome flat-remix gnome-tweaks gnome-shell-extension-top-icons-plus acpi
}


install_zsh_fonts() {
  #--------------------------------------------------------------------------------
  # Install from web
  #--------------------------------------------------------------------------------
  #@ oh-my-zsh
  if [ ! -e "$HOME/.oh-my-zsh" ]; then
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
    # zsh plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
      "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    git clone git://github.com/zsh-users/zsh-autosuggestions \
      "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    git clone https://github.com/paulirish/git-open.git \
      "$ZSH_CUSTOM/plugins/git-open"
    if [ -e "$HOME/.zsh.pre-oh-my-zsh" ]; then
      mv $HOME/.zsh.pre-oh-my-zsh $HOME/.zshrc
    fi
    if [ -e "/root/.oh-my-zsh" ]; then
      rm -r /root/.oh-my-zsh && cp -r /home/alanding/.oh-my-zsh /root/
    fi
  fi

  #@ install fonts
  sudo cp -r "$mydotfile/fonts/powerline" /usr/share/fonts
  sudo fc-cache -vf

  # ssh
  # rm $HOME/.ssh && ssh localhost || cd ~/.ssh && ssh-keygen -t rsa && cat ./id_rsa.pub >> ./authorized_keys

  # 版本修改 gcc and g++
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 60
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 50
  # update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 40
  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 60
  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 50
  # update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 40
}

install_vim() {
  #@ SpaceVim
  if [ ! -e "$HOME/.SpaceVim" ]; then
    sh "$mydotfile/ide-config/vim-install/linux-MyVim-install.sh"
  fi
}


lang_install() {
  # --------------------------------------------------------------------------------
  # Lang install 
  # --------------------------------------------------------------------------------
  vimroot=/home/alanding/.SpaceVim.d

  declare -a lang
  lang=(cpp go lua nodejs python)
  for lang in ${lang[*]}; do
    sh "$vimroot/extools/lang-install/$lang"
  done
}


install_wine_code_google() {
  #--------------------------------------------------------------------------------
  # Install from disk  
  #--------------------------------------------------------------------------------
  #@ Deepin-wine
  if [ ! -x "/usr/bin/deepin-wine" ]; then
    cpath=$(pwd)
    # sh /mnt/fun+downloads/linux系统安装/daily-software/deepin-wine-env/install.sh

    # source website
    # http://www.wps.cn/product/wpslinux/#
    # https://pinyin.sogou.com/linux/?r=pinyin
    # https://music.163.com/#/download
    # http://www.xm1math.net/texmaker/download.html
    # https://www.xmind.net/download/xmind8
    # https://github.com/wszqkzqk/deepin-wine-ubuntu

    cd /mnt/fun+downloads/linux系统安装/daily-software || return
    #@ Google
    rm -f google-chrome-stable_current_amd64.deb
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    #@ rg search
    # curl -LO https://github.com/BurntSushi/ripgrep/releases/download/
    dpkg -i ./*.deb


    #@ vscode fd
    cd /mnt/fun+downloads/linux系统安装/code-software || return
    dpkg -i ./*.deb

    # tex 换源
    #tlmgr option repository http://mirrors.ustc.edu.cn/CTAN/systems/texlive/tlnet
    cd "$cpath" || return
  fi

  # fix dependencies
  apt-get --fix-broken install
  apt-get autoclean && apt-get autoremove && apt-get clean
  #@ icons
  cp -r "$mydotfile/linux/alan-root/.*" "$HOME"
  cp -r "$mydotfile/system-theme/icons/*" /usr/share/applications
}


install_nvidia() {
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
      chmod +x ./*.run | ./NVIDIA-Linux-x86_64-410.78.run
    fi
  fi
}

install_yarnpkg() {
  ln -sf /opt/lang-tools/nvm/versions/node/v11.9.0/bin/node /usr/bin/nodejs
  ln -sf /opt/lang-tools/nvm/versions/node/v11.9.0/bin/node /usr/bin/node
}

# preparation
# remove_useless
# install_apps
# install_zsh_fonts
# install_vim
# install_yarnpkg
# lang_install
# install_wine_code_google
install_nvidia

