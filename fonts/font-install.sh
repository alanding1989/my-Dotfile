#! /usr/bin/env bash

mydotfile=$(cd $(dirname $(dirname $0)); pwd)

# @ install fonts
  cp -r $mydotfile/fonts/powerline /usr/share/fonts
  fc-cache -vf
