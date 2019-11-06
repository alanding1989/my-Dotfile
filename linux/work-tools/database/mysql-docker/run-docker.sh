#! /usr/bin/env bash


# File Name    : run-docker.sh
# Author       : AlanDing
# Created Time : Mon 21 Oct 2019 08:24:41 PM CST
# Description  : 


if [ $1 == '' ]; then
  # -rm
  docker run -dit --name mysql-latest -p 3306:3306 -e MYSQL_ROOT_PASSWORD=193728456 --restart=always mysql:latest
elif [ $1 == '5' ]; then
  docker run -dit --name mysql-5.7 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=193728456 --restart=always mysql:5.7
else
  echo 'invalid version args'
fi

