#! /usr/bin/env bash

# =====================================================
# for build gvim manually
# =====================================================



# dependencies
# sudo apt-get install libncurses5-dev python-dev python3-dev libgtk3.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev


./configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-pythoninterp --enable-python3interp --enable-luainterp --enable-cscope --enable-gui=gnome2 --enable-perlinterp --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/ --prefix=/opt/vim/vim8.1


make clean
