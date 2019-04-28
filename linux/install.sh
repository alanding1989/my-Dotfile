#! /usr/bin/env bash

echo "=================================================================="
echo "\n"
echo "======================== 开始安装 ================================="

if [ ! x 'usr/bin/git']; then
  sudo apt-install git
fi

rm -r /tmp/alan-dotfile
git clone git@github.com:alanding1989/alan-dotfile.git /tmp/alan-dotfile
cd /tmp/alan-dotfile

if [ ! -d "./log" ]; then
	mkdir ./log
fi

sh ./ubuntu-setup.sh | tee ./log/install-log.txt

echo "======================== 安装完成！ ================================"
echo "\n"
echo "安装记录保存在/log/install-log.txt文件中。"
