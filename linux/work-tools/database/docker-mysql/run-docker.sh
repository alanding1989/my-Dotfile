#! /usr/bin/env bash


# File Name    : run-docker.sh
# Author       : AlanDing
# Created Time : Mon 21 Oct 2019 08:24:41 PM CST
# Description  : 


docker run -dit --rm --name docker-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=193728456 mysql:latest

