#! /usr/bin/env zsh


# ==================================================================================
# ZSH Configuration
# ============================================================================== {{{
ZshSettings() {
  # Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

  # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
  #ZSH_THEME="ys"
  ZSH_THEME="lambda-mod"

  # Uncomment the following line to enable command auto-correction.
  # ENABLE_CORRECTION="true"

  # Uncomment the following line to display red dots whilst waiting for completion.
  COMPLETION_WAITING_DOTS="true"

  # Uncomment the following line if you want to disable marking untracked files
  # under VCS as dirty. This makes repository status check for large repositories much, much faster.
  # DISABLE_UNTRACKED_FILES_DIRTY="true"

  HIST_STAMPS="yyyy/mm/dd"

  # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  plugins=(git wd	z extract history web-search sbt
          git-open zsh-syntax-highlighting zsh-autosuggestions docker docker-compose)
  fpath+=$HOME/.oh-my-zsh/custom/plugins/rustcompletion
  fpath+=$HOME/.oh-my-zsh/custom/plugins/ninja-completion
  fpath+=$HOME/.oh-my-zsh/custom/plugins/gradle-completion
  fpath+=$HOME/.oh-my-zsh/custom/plugins/conda-completion

  zstyle ':completion::complete:*' use-cache 1

  # Enable autosuggestions automatically.
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

  export UPDATE_ZSH_DAYS=30

  #@ User configuration
  export MANPATH="/usr/local/man:$MANPATH"

  # You may need to manually set your language environment
  export LANG=en_US.UTF-8

  # Compilation flags
  export ARCHFLAGS="-arch x86_64"

  # ssh
  export SSH_KEY_PATH="~/.ssh/rsa_id"

  source $ZSH/oh-my-zsh.sh

  # autocomplete keybinding
  bindkey '`' autosuggest-accept

  # man 着色
  export LESS_TERMCAP_mb=$'\e[1;32m'
  export LESS_TERMCAP_md=$'\e[1;32m'
  export LESS_TERMCAP_me=$'\e[0m'
  export LESS_TERMCAP_se=$'\e[0m'
  export LESS_TERMCAP_so=$'\e[01;33m'
  export LESS_TERMCAP_ue=$'\e[0m'
  export LESS_TERMCAP_us=$'\e[1;4;31m'
}
# }}}


# ==================================================================================
# Commands Aliases Definition
# =============================================================================== {{{
DefAlias() {
# For a full list of active aliases, run `alias`.
  # system operation
  alias pdf='synclient touchpadoff=1'
  alias pdo='synclient touchpadoff=0'
  alias alc='update-alternatives --config'
  alias ali='update-alternatives --install'
  alias apti="apt-get install"
  alias aptug="apt-get upgrade"
  alias aptud="apt-get update"
  alias aptf="apt-get -f install"
  alias aptre="apt-get remove"
  alias aptar='apt-get autoremove && apt-get autoclean && apt-get clean'
  alias aptsh='apt show'
  alias md="mkdir -p"
  alias df="df -h"
  alias mv="mv -i"
  alias cp="cp -rf"
  alias rm="rm -rf"
  alias la="ls -a -htrF"
  alias ll="ls -la -lhtrF"
  alias l.="ls -lhtrdF .*"
  alias cl="colorls -A --sd"
  alias clf="colorls -A -f --sd"
  alias cld="colorls -A -d --sd"
  alias cll="colorls -lA --sd"
  alias cgt="colorls --gs -t"
  alias cgl="colorls --gs -lA --sd"

  alias encconvert='convmv'
  alias sysbackup='sh /mnt/fun+downloads/linux系统安装/systembackup/sysbackup.sh'


  # editor
  alias ge='gedit'
  alias em='emacs -nw'
  alias nv='nvim'
  alias typora='~/software/Typora/Typora'
  alias tmk="tmux kill-server"
  # config files
  alias zrc="nv ~/.zshrc"
  alias brc="nv ~/.bashrc"
  alias vrc="nv ~/.SpaceVim.d/vimrc"
  alias trc="nv ~/.tmux.conf"
  alias szsh="source ~/.zshrc"

  # App
  alias yinyue='sudo netease-cloud-music'
  alias xmind='cp=$pwd; cd /home/alanding/software/xmind-8/XMind_amd64 && ./XMind; cd $cp'
  alias irc='irssi'
  # acinema
  alias acinema='asciinema'
  alias arec='asciinema rec'
  alias arect='asciinema rec -t'
  alias apl='asciinema play'
  alias aul='asciinema upload'
  alias aauth='asciinema auth'
  alias acat='asciinema cat'
  # translator
  alias jj='python3 /home/alanding/.SpaceVim.d/extools/translator/translator.py '

  # Devtools
  # Spark
  alias starthdfs='start-dfs.sh && start-yarn.sh && start-master.sh && start-slaves.sh'
  alias stophdfs='stop-dfs.sh && stop-yarn.sh && stop-master.sh && stop-slaves.sh'
  alias hf='hadoop fs'

  # Cargo
  alias rr='cargo run'
  alias rb='cargo build'

  # Git
  alias gch='git checkout'
  alias grh='git reset --hard'
  alias gpod='git push origin --delete'
  alias gdrb='git push origin '
  alias grro='git remote remove origin'
  alias grru='git remote remove upstream'
  alias gclr='git clone'

  # Sphinx
  alias sphstart='sphinx-quickstart'
  alias sphbuild='sphinx-build'
  alias sphapidoc='sphinx-apidoc'
  alias sphgen='sphinx-autogen'
  # Jupyter
  alias jpnb='jupyter-notebook'
  alias jpto='jupyter nbconvert --to'

  # Python pkg
  alias cookieml='cookiecutter https://github.com/drivendata/cookiecutter-data-science'
  alias cookiegeneral='cookiecutter git@github.com:audreyr/cookiecutter-pypackage.git'

  # ---------------------------------------------------------------------------------------
  alias mysql='mysql -u root -p'
  alias mongod='mongod --dbpath /home/alanding/software/database/mongodb'

  # fun
  alias rcat="nyancat"
  alias clock="while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done&"

  # grep keyword file | keyword 
  alias grep="grep --color=auto"

  # -------------------------------------------------------------------------------------------------
  # @运维命令
  # -------------------------------------------------------------------------------------------------
  # less tail head 等查看文件内容
  # systemctl status 查看应用状况

  ### 1. 查看性能
  # top 查看系统整体性能查看总览

  ### 2. CPU性能
  # mpstat -P ALL 2
  # vmstat -n 采样时间间隔 + 采样次数
  #   -procs
  #     r：运行等待CPU时间片的进程数，原则上1核的CPU运行队列不要超过2，整个系统的运行队列不能超过总核数的2倍，否则代表系统压力过大。
  #   -cpu
  #     us：用户进程消耗CPU时间百分比，us值高，用户进程小号CPU时间多，如果长期大于50%，优化程序；
  #     sy：内核进程消耗的CPU百分比；

  ### 3. 查看系统已使用及可用内存变化
  alias free='free -h -s3'
  # pidstat -p 进程号 -r(指内存统计) + 采样间隔
  #
  # 查看文件系统及硬盘空间状况
  # df -h
  #
  # estimate file space usage
  alias du="du -h"

  # 查看磁盘IO性能
  alias iostat='iostat -xdk 2, 3' 
  # pidstat -p 进程号 -d(指磁盘IO统计) + 采样间隔

  ### 4. 网络
  # ifstat 查看网络IO性能
  #
  # 查看Ip，网络连接，端口占用等总览，加上.. | grep PID 查看具体进程占用端口 -tunlp tcp udp numeric listening program
  alias netstat='netstat -tunlp'
  #
  # lsof -i tcp:80 
  alias portcheck="lsof -i"

  # @@ 查找对应PID 后接应用程序名
  alias psgrep='ps -ef | grep '
  # 找进程中占用CPU较高的线程
  # ps -p ..pid.. -L -o pcpu,pid,tid,time,tname,cmd > ~/...

  # 输出某进程<pid>并检查该进程内运行的线程状况
  # top -H -p <pid>

  # Java 诊断工具
  alias arthas='java -jar $HOME/software/lang-tools/Java/Arthas/arthas-boot.jar'
  # jps -v JVM启动时参数列表
  #     -m 传给主类参数
  #     -l 列出主类、Jar包位置
  #
  # jstat -gcutil `pid`
  alias jstat='jstat -gcutil'
  #
  # jinfo 实时查看和调整虚拟机各项参数
  #
  # jmap 生成堆转储快照
  #
  # 生成JVM当前时刻线程快照，定位线程长时间停顿原因，死锁、死循环、请求外部资源等。
  # -l 输出锁信息，-F 强制输出线程堆栈，-m 如调用本地方法，可显示C/C++堆栈。
  alias jstack='jstack -l'

  alias jps='jps -l'

  # docker
  alias drmc-all="docker rm $(docker ps -a -q) -f"
}
# }}}


# ==================================================================================
# Environment Variable Definition
# =============================================================================== {{{
DefEnVar() {
  export PATH=/home/alanding/.local/bin:$PATH
  export TERM=xterm-256color

  export ALANDOTFILE=/mnt/fun+downloads/my-Dotfile

  # Preferred editor for local and remote sessions
  export EDITOR=/opt/vim/nvim-linux64/bin/nvim

  # Browser for ensime
  export BROWSER="google-chrome %s"

  # Git
  export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
  export LESSCHARSET=utf-8

  # Conda
  export PATH=/home/alanding/software/anaconda3/envs/py37/bin:$PATH
  \. /home/alanding/software/anaconda3/etc/profile.d/conda.sh
  # MiniConda
  # export PATH=//home/alanding/software/lang-tools/miniconda/bin:$PATH
  # \. /home/alanding/software/lang-tools/miniconda/etc/profile.d/conda.sh
  alias condacheat='okular $HOME/.SpaceVim.d/cheats/conda-cheatsheet.pdf'

  # Pip cli completion
  eval "`pip completion --zsh`"

  # CUDA
  export CUDA_HOME=/home/alanding/software/cuda/cuda-10.0
  export PATH=$CUDA_HOME/bin:$PATH
  export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
  export CUDA_DEVICE_ORDER="PCI_BUS_ID"
  export CUDA_VISIBLE_DEVICES="0,1,2,3"

  # OpenCV
  export OPENCV_HOME=/opt/lang-tools/cpp/opencv/
  export PATH=$OPENCV_HOME/bin:$PATH

  # Clang
  export CLANG_HOME=/opt/lang-tools/cpp/clang
  export PATH=${CLANG_HOME}/bin:${CLANG_HOME}/lib:${CLANG_HOME}/libexec:$PATH
  # Cmake
  # export PATH=/opt/lang-tools/cpp/cmake/bin:$PATH

  # Rust
  export RUSTUP_HOME=/opt/lang-tools/rust/rustup
  export CARGO_HOME=/home/alanding/software/lang-tools/cargo
  export PATH=$CARGO_HOME/bin:$PATH
  export RUST_SRC_PATH=$RUSTUP_HOME/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
  export RUSTUP_DIST_SERVER=http://mirrors.ustc.edu.cn/rust-static
  export RUSTUP_UPDATE_ROOT=http://mirrors.ustc.edu.cn/rust-static/rustup

  # Go
  export GOROOT=/opt/lang-tools/go/go
  export PATH=$GOROOT/bin:$PATH
  export GOPATH=/home/alanding/software/lang-tools/go
  export PATH=$GOPATH/src:$PATH
  export GOBIN=/home/alanding/software/lang-tools/go/bin
  export PATH=$GOBIN:$PATH
  # export GO111MODULE=on

  # Julia
  export PATH=/opt/lang-tools/julia/julia/bin:$PATH


  # Java
  export JAVA_HOME=/opt/lang-tools/java/jdk
  export JRE_HOME=${JAVA_HOME}/jre
  export PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin:$PATH
  # Maven
  export MAVEN_HOME=/opt/lang-tools/java/maven
  export PATH=${MAVEN_HOME}/bin:$PATH
  # Gradle
  export GRADL_HOME=/opt/lang-tools/java/gradle
  export PATH=${GRADL_HOME}/bin:$PATH

  # Tomcat
  # export PATH=/home/alanding/software/web-server/tomcat/bin:$PATH

  # Scala
  export SCALA_HOME=/opt/lang-tools/scala/scala
  export PATH=${SCALA_HOME}/bin:$PATH
  export PATH=/opt/lang-tools/scala:$PATH
  # export PATH=/opt/lang-tools/scala/languageclient:$PATH
  export PATH=/opt/lang-tools/scala/coc:$PATH
  # Sbt
  export PATH=/opt/lang-tools/scala/sbt/bin:$PATH

  # Spark
  export SPARK_HOME=/home/alanding/software/spark/spark
  export PATH=${SPARK_HOME}/bin:${SPARK_HOME}/sbin:$PATH
  # Pyspark
  export PYSPARK_DRIVER_PYTHON=jupyter
  export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
  export PYSPARK_PYTHON=/home/alanding/software/anaconda3/envs/py37/bin/python3.7
  # Hadoop
  export HADOOP_HOME=/home/alanding/software/spark/hadoop
  export PATH=${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:$PATH
  export HDFS_DATANODE_USER=alanding
  export HDFS_NAMENODE_USER=alanding
  export HDFS_SECONDARYNAMENODE_USER=alanding
  export YARN_NODEMANAGER_USER=alanding
  export YARN_RESOURCEMANAGER_USER=alanding


  # .net
  export PATH=/opt/lang-tools/csharp:$PATH


  # Node version manager
  export NVM_DIR="/opt/lang-tools/nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # autoload -U add-zsh-hook
  load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"
    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  # yarn
  export PATH=`dirname $(which node)`:$PATH

  #lua
  export PATH=/opt/lang-tools/lua/luarocks/bin:$PATH

  # Ruby
  if [ `whoami` != "root" ]; then
  # if [ $UID -ne 0 ]; then
    export PATH=$HOME/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
    if [ -x gem ]; then
      \. $(dirname $(gem which colorls))/tab_complete.sh
    fi
  fi


  # Vim
  export VIM_HOME=/opt/vim
  export PATH=${VIM_HOME}/vim8.1/bin:$PATH
  export PATH=${VIM_HOME}/nvim-linux64/bin:$PATH
  # Neovim-remote/spacevim
  export PATH=$HOME/.SpaceVim/bin:$PATH
  # Ctags and Gtags
  export PATH=/opt/vim/universal-ctags/bin:$PATH
  export PATH=/opt/vim/gtags/bin:$PATH
  export GTAGSLABEL=native-pygments
  export GTAGSCONF=$HOME/.globalrc
  # Gtm
  export PATH=/opt/vim/gtm.v1.3.5.linux:$PATH
  # LanguageTool
  export LANGUAGE_TOOL_HOME=/opt/vim/LanguageTool

  # Emacs
  # export EMACS_HOME=/opt/emacs
  # export PATH=${EMACS_HOME}/emacs/bin:$PATH

  # TEX
  export PATH=/home/alanding/software/texlive/2018/bin/x86_64-linux:$PATH
  export MANPATH=/home/alanding/software/texlive/2018/texmf-dist/doc/man:$MANPATH
  export INFOPATH=/home/alanding/software/texlive/2018/texmf-dist/doc/info:$INFOPATH

  # postman, vagrant, chromedriver ...
  export PATH=/home/alanding/software/command-line-tools:$PATH
}
# }}}

 
# ==================================================================================
# Function Tools Definition
# =============================================================================== {{{
pidCheck() {
  # check pid tid, locate thread problem
  ps p ${1} -L -o pcpu,pmem,pid,tid,time,tname,cmd
}


jstackCheck() {
  local pid=hToD $1
  jstack -l $pid > $HOME/jstack.log
}


codi() {
# Codi Usage: codi [filetype] [filename]
  local syntax="${1:-python}"
  shift
  vim -c \
    "set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermby=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

# utils
hToD() {
  printf "%x\n" $1
}

# }}}


# ==================================================================================
# Others
# ==============================================================================# {{{
# Fzf
FzfConfig() {
  [ -f /opt/vim/fzf/.fzf.zsh ] && source /opt/vim/fzf/.fzf.zsh
  export FZF_TMUX=1
  export FZF_COMPLETION_TRIGGER='ff'
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude={.git, .idea, .vacode, .project, .sass-cache, node_modules, build}"
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || bat {}) 2> /dev/null | head -500'"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_CTRL_T_OPTS="--select-1 --exit-0"
  export FZF_ALT_C_OPTS="--preview --select-1 --exit-0 'tree -C -p -s {} | head -200'"
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
  cdf() {
    local file
    local dir
    file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
  }
  fh() {
    eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
  }
}

# disable Vim freeze after pressing <C-s>
stty -ixon
# }}}


# ==================================================================================
# Load Configuration
# ==============================================================================# {{{
ZshSettings
DefAlias
DefEnVar

FzfConfig
# }}}

