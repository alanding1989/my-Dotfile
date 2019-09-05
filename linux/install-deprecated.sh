#! /usr/bin/env bash

echo "=================================================================="
printf "\n"
echo "======================== 开始安装 ================================"

if [ ! -x "usr/bin/git" ]; then
  sudo apt-install git
fi

rm -r /tmp/my-Dotfile
git clone git@github.com:alanding1989/my-Dotfile.git /tmp/my-Dotfile
cd /tmp/my-Dotfile || return

if [ ! -d "./log" ]; then
	mkdir ./log
fi

sh ./ubuntu-setup.sh | tee ./log/install-log.txt

echo "======================== 安装完成！ ==============================="
printf "\n"
echo "安装记录保存在/log/install-log.txt文件中。"
