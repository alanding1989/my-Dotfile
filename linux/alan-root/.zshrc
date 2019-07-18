#! /usr/bin/env zsh


# ==================================================================================

ZshSettings() {
  # Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

  # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
  #ZSH_THEME="ys"
  ZSH_THEME="lambda-mod"

  # Uncomment the following line to enable command auto-correction.
  ENABLE_CORRECTION="true"

  # Uncomment the following line to display red dots whilst waiting for completion.
  COMPLETION_WAITING_DOTS="true"

  # Uncomment the following line if you want to disable marking untracked files
  # under VCS as dirty. This makes repository status check for large repositories much, much faster.
  # DISABLE_UNTRACKED_FILES_DIRTY="true"

  HIST_STAMPS="yyyy/mm/dd"

  # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  plugins=(git wd	z extract history web-search sbt
          git-open zsh-syntax-highlighting zsh-autosuggestions)

  # Enable autosuggestions automatically.
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

  export UPDATE_ZSH_DAYS=30

  #@ User configuration
  export MANPATH="/usr/local/man:$MANPATH"

  # You may need to manually set your language environment
  export LANG=en_US.UTF-8

  # Compilation flags
  # export ARCHFLAGS="-arch x86_64"

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

# ==================================================================================

# For a full list of active aliases, run `alias`.
DefAlias() {
  alias pdf='synclient touchpadoff=1'
  alias pdo='synclient touchpadoff=0'
  alias upalc='update-alternatives --config'
  alias upali='update-alternatives --install'
  alias apti="apt-get install"
  alias aptug="apt-get upgrade"
  alias aptud="apt-get update"
  alias aptfi="apt-get -f install"
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
  alias grep="grep --color=auto"
  # app
  alias yinyue='sudo netease-cloud-music'
  alias xmind='cd /home/alanding/software/xmind-8/XMIND_amd64/ | ./XMind'
  alias sysbackup='sh /mnt/fun+downloads/linux系统安装/systembackup/sysbackup.sh'
  alias ge='gedit'

  # config
  alias zrc="nv ~/.zshrc"
  alias brc="nv ~/.bashrc"
  alias vrc="nv ~/.SpaceVim.d/vimrc"
  alias trc="nv ~/.tmux.conf"
  alias szsh="source ~/.zshrc"

  alias asne='asciinema'
  alias arec='asciinema rec'
  alias arect='asciinema rec -t'
  alias apl='asciinema play'
  alias aul='asciinema upload'
  alias ath='asciinema auth'
  alias acat='asciinema cat'
  alias tmk="tmux kill-server"
  alias nv='nvim'
  alias em='emacs'

  # sphinx
  alias sphq='sphinx-quickstart'
  alias sphb='sphinx-build'
  alias spha='sphinx-apidoc'
  alias sphg='sphinx-autogen'

  # spark
  alias starthdfs='start-dfs.sh && start-yarn.sh && start-master.sh && start-slaves.sh'
  alias stophdfs='stop-dfs.sh && stop-yarn.sh && stop-master.sh && stop-slaves.sh'
  alias hf='hadoop fs'

  # git
  alias gch='git checkout'
  alias grh='git reset --hard'
  alias gpod='git push origin --delete'
  alias gdrb='git push origin '
  alias grro='git remote remove origin'
  alias grru='git remote remove upstream'

  # translate
  alias jj='python3 /home/alanding/.SpaceVim.d/extools/translator/translator.py '
  # alias rmysql='mysql -u root -p'
  alias mysql='mysql -u alanding -p'
}


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

  # Conda
  export PATH=/home/alanding/software/anaconda3/envs/py36/bin:$PATH
  \. /home/alanding/software/anaconda3/etc/profile.d/conda.sh

  # CUDA
  export CUDA_HOME=/home/alanding/software/cuda/cuda-10.0
  # export PATH=$CUDA_HOME/bin:$PATH
  # export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
  export PATH=$CUDA_HOME/bin${PATH:+:${PATH}}
  export LD_LIBRARY_PATH=$CUDA_HOME/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
  export CUDA_DEVICE_ORDER="PCI_BUS_ID"
  export CUDA_VISIBLE_DEVICES="0,1,2,3"

  # Clang
  export CLANG_HOME=/opt/lang-tools/cpp/clang
  export PATH=${CLANG_HOME}/bin:${CLANG_HOME}/lib:${CLANG_HOME}/libexec:$PATH

  # Java
  export JAVA_HOME=/opt/lang-tools/java/jdk
  export IDEA_JDK=/opt/lang-tools/java/jdk
  export JRE_HOME=${JAVA_HOME}/jre
  export CLASSPATH=${JAVA_HOME}/lib:${JRE_HOME}/lib
  export PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin:${CLASSPATH}:$PATH
  # Maven
  export MAVEN_HOME=/opt/lang-tools/maven
  export PATH=${MAVEN_HOME}/bin:$PATH

  # Scala
  export SCALA_HOME=/opt/lang-tools/scala/scala-2.12.8
  export PATH=${SCALA_HOME}/bin:$PATH
  export SCALA_DOC=${SCALA_HOME}/bin/scaladoc
  export SCALA_COMPILER=${SCALA_HOME}/bin/scalac
  # metals-vim, coursier
  export PATH=/opt/lang-tools/scala:$PATH
  # export PATH=/opt/lang-tools/scala/languageclient:$PATH
  export PATH=/opt/lang-tools/scala/coc:$PATH

  # Sbt
  export PATH=/opt/lang-tools/scala/sbt/bin:$PATH

  # Spark
  export SPARK_HOME=/opt/spark/spark-2.4.0
  export PATH=${SPARK_HOME}/bin:${SPARK_HOME}/sbin:$PATH
  # Pyspark
  export PYSPARK_DRIVER_PYTHON=jupyter
  export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
  export PYSPARK_PYTHON=/home/alanding/software/anaconda3/envs/py36/bin/python3.6
  # Hadoop
  export HADOOP_HOME=/opt/spark/hadoop
  export PATH=${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:$PATH
  export HDFS_DATANODE_USER=alanding
  export HDFS_NAMENODE_USER=alanding
  export HDFS_SECONDARYNAMENODE_USER=alanding
  export YARN_NODEMANAGER_USER=alanding
  export YARN_RESOURCEMANAGER_USER=alanding

  # TEX
  export PATH=/home/alanding/software/texlive/2018/bin/x86_64-linux:$PATH
  export MANPATH=/home/alanding/software/texlive/2018/texmf-dist/doc/man:$MANPATH
  export INFOPATH=/home/alanding/software/texlive/2018/texmf-dist/doc/info:$INFOPATH

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

  # Ruby
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
  source $(dirname $(gem which colorls))/tab_complete.sh

  # Go
  export GOROOT=/opt/lang-tools/go/go
  export GOPATH=/home/alanding/go/
  export GOBIN=/home/alanding/go/bin
  export PATH=$GOROOT/bin:$PATH
  export PATH=$GOPATH/src:$PATH
  export PATH=$GOBIN:$PATH
  # export GO111MODULE=on

  #lua
  export PATH=/opt/lang-tools/lua/luarocks/bin:$PATH

}


# Others
# ==================================================================================

# Codi Usage: codi [filetype] [filename]
codi() {
  local syntax="${1:-python}"
  shift
  vim -c \
    "set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermby=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
  }

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
FzfConfig

# disable Vim freeze after pressing <C-s>
stty -ixon

ZshSettings
DefAlias
DefEnVar

