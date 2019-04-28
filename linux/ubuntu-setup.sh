#! /usr/bin/env bash

read -rp "Install or update ->: [i/u]" bb
if [ $bb = i ]; then
  echo "start installation"
elif [ $bb = u ]; then
  echo "update now"
else
  echo "invalid input!!"
  exit
fi

#-------------- Add source and Remove some useless software {{{
if [ $bb = i ]; then
  add-apt-repository ppa:daniruiz/flat-remix
  add-apt-repository ppa:noobslab/macbuntu
  apt-add-repository ppa:zanchey/asciinema

  apt-get remove unity-webapps-common
  apt-get remove thunderbird totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot
  apt-get remove gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku  landscape-client-ui-install
  apt-get remove onboard deja-dup
  apt-get remove libreoffice-common
  apt-get remove firefox*
fi
# }}}

#-------------- Install from ubuntu source {{{
apt-get update
apt-get install zsh vim git git-extras tig tmux guake albert gdebi curl tsocks jq goldendict urlview xclip ripgrep silversearcher-ag
apt-get install xserver-xorg-input-synaptics synaptic openssh-server asciinema
apt-get install build-essential gcc-7 g++-7 global

# system theme
#@ user themes/ dash to dock/ hide top bar/ weather in the clock
apt-get install flat-remix-gnome flat-remix
apt-get install gnome-tweaks gnome-shell-extension-top-icons-plus acpi

# }}}

if ! grep -q PYSPARK_PYTHON "/etc/profile"; then
  echo "export JAVA_HOME=/opt/lang-tools/java/jdk1\
    \nexport JDK_HOME=/opt/lang-tools/java/jdk\\
      \nexport PYSPARK_PYTHON=/home/alanding/software/anaconda3/envs/py36/bin/python3.6" >> /etc/profile
fi

#-------------- Install from web {{{

#@ oh-my-zsh
if [ ! -e "$HOME/.oh-my-zsh" ]; then
  wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
  #@ zsh plugins
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  git clone https://github.com/paulirish/git-open.git $ZSH_CUSTOM/plugins/git-open
  if [ -e "$HOME/.zsh.pre-oh-my-zsh" ]; then
    mv ~/.zsh.pre-oh-my-zsh ~/.zshrc
  fi
else
  cd "$HOME/.zsh" && git pull
fi

if [ $bb = i ]; then
  chsh -s /bin/zsh root
  zsh
  cp ./alan-root/.* $HOME/

  # @ install fonts
  cp -r ./fonts/sourcecodepro-fonts /usr/share/fonts
  fc-cache -vf

  # @ icons
  cp ./theme-system/icons/*.desktop /usr/share/applications

  # @ pip
  if [ ! -x "/usr/bin/pip" ]; then
    ln -s /home/alanding/software/anaconda3/envs/py36/bin/pip usr/bin/pip
  fi

  # ssh
  #@ TODO add privatekey to github
  rm ~/.ssh && ssh localhost || cd ~/.ssh && ssh-keygen -t rsa && cat ./id_rsa.pub >> ./authorized_keys

  # 版本修改gcc and g++
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 40
  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 60
  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 40

  source ~/.zshrc
fi

#@ SpaceVim
if [ ! -e "$HOME/.SpaceVim" ]; then
  curl -sLf https://spacevim.org/cn/install.sh | bash -s -- --install neovim
  # curl -sLf https://spacevim.org/cn/install.sh | bash -s -- -h
  # curl -sLf https://spacevim.org/cn/install.sh | bash -s -- --uninstall
  if [ ! -e "/root/.SpaceVim" ]; then
    ln -s /home/alanding/.SpaceVim /root/.SpaceVim
    ln -s /home/alanding/.vim      /root/.SpaceVim.d
  fi
  if [ ! -e "/home/alanding/.SpaceVim.d" ]; then
    ln -s /home/alanding/.vim      /home/alanding/.SpaceVim.d
  fi
else
  cd "$HOME/.SpaceVim" && git pull
fi

#@ Nodejs
if [ ! -e "/opt/nvm" ]; then
  # curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
  git clone https://github.com/creationix/nvm.git /opt/nvm
  nvm install v11.9.0
  nvm alias default v11.9.0
  source $HOME/.zshrc
  npm -g i nrm
  nrm use taobao
  npm -g i yarn
  npm config set "@fortawesome:registry" https://npm.fontawesome.com/ && \
    npm config set "//npm.fontawesome.com/:_authToken" TOKEN
  $YARN_HOME config set registry 'https://registry.npm.taobao.org'
  # install yarn
  # curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  # echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  # sudo apt-get update && sudo apt-get install --no-install-recommends yarn
else
  cd /opt/.nvm && git pull
fi
nodepath=$(which node)
ln -s /usr/bin/node ${nodepath}
# update
npm -g i nrm
npm -g i yarn
npm -g i rimraf
npm -g i neovim
npm -g i wcwidth
npm -g i remark
npm -g i remark-cli
npm -g i remark-stringify
npm -g i bash-language-server
npm -g i import-js
npm -g i javascript-typescript-langserver
npm -g i vscode-css-languageserver-bin
npm -g i --save-dev @fortawesome/fontawesome-free
yarn global add prettier
yarn global add diagnostic-languageserver

if [ ! -e "$HOME/.rbenv" ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  source $HOME/.zshrc
  ~/.rbenv/bin/rbenv init
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  # ruby-dependencies
  apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
  rbenv install 2.6.0
  rbenv global 2.6.0
  gem install neovim
  gem install bundler
  gem install colorls
  gem install rainbow
  rbenv rehash
  rehash
else
  cd "$HOME/.rbenv" && git pull
fi


if [ ! -e "$HOME/go" ]; then
  go get -u github.com/saibing/bingo
  go get -u github.com/sourcegraph/go-langserver
  go get -u github.com/haya14busa/go-vimlparser/cmd/vimlparser
fi


#@ Google
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

#@ rg search
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.12.0/ripgrep_0.12.0_amd64.deb
dpkg -i *.deb

# }}}


#---------------- Install from disk {{{

#@ Deepin-wine
if [ ! -x "/usr/bin/deepin-wine" ]; then
  sh /mnt/fun+downloads/linux系统安装/dayly-software/deepin-wine-ubuntu-master/install.sh
  cd /mnt/fun+downloads/linux系统安装/dayly-software/ && dpkg -i ./*.deb
  echo "export JAVA_HOME=/opt/spark/java/jdk1.8.0_191" >> /etc/profile
  echo "export PYSPARK_PYTHON=/usr/bin/python3.6" >> /etc/profile

  # tex 换源
  tlmgr option repository http://mirrors.ustc.edu.cn/CTAN/systems/texlive/tlnet
fi
# source website
# http://www.wps.cn/product/wpslinux/#
# https://pinyin.sogou.com/linux/?r=pinyin
# https://music.163.com/#/download
# http://www.xm1math.net/texmaker/download.html
# https://www.xmind.net/download/xmind8
# https://github.com/wszqkzqk/deepin-wine-ubuntu

# vscode, fd
if [ ! -x "/usr/bin/code" ]; then
  cd /mnt/fun+downloads/linux系统安装/code-software || return
  dpkg -i ./*.deb
fi
# }}}


# fix dependencies {{{
apt-get --fix-broken install
apt-get autoclean && apt-get autoremove && apt-get clean
# }}}

#---------------- Copy systembackup {{{
# if [ ! -e "/opt/spark" ]; then
  # cp -r /mnt/fun+downloads/linux系统安装/systembackup/备份脚本/opt/ /
# fi
# }}}


# utils and conf {{{
if [ ! -z $(lsmod | grep nouveau) ]; then
  echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
  update-initramfs -u
fi

if [ -z $(nvidia-smi) ]; then
  read -pr "Confirm to remove Nvidia? [y/n] ->:" cc
  if [ $cc = y ]; then
    apt-get remove --purge nvidia*
    cd /mnt/fun+downloads/linux系统安装/code-software/system-util
    chmod +x *.run | ./NVIDIA-Linux-x86_6<4-410.78.run
  fi
fi
# }}}
