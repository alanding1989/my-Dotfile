#! /usr/bin/env bash


# File Name    : run-docker.sh
# Author       : AlanDing
# Created Time : Mon 21 Oct 2019 08:24:41 PM CST
# Description  : 


if [ $1 == 'latest' ]; then
  docker run -dit --rm --name mysql-latest -p 3306:3306 -e MYSQL_ROOT_PASSWORD=193728456 mysql:latest
elif [ $1 == '5' ]; then
  docker run -dit --rm --name mysql-5.7 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=193728456 mysql:5.7
else
  echo 'invalid version args'
fi

