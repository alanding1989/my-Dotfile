#! /usr/bin/env bash


# File Name    : linux/work-tools/docker/rabbitmq/rabbitmq-docker.sh
# Author       : AlanDing
# Created Time : Mon 18 Nov 2019 03:55:40 PM CST
# Description  : 

# 提供交互-it 
# -e 限制es启动堆内存，它默认为2G...，自己电脑运行太大，抗不住

if [ $1 == '' ]; then
    docker run -d --name ES01 -p 9200:9200 -p 9300:9300 -e ES_JAVA_OPTS="-Xms256m -Xmx256m" \
        --restart=always elasticsearch
elif [ $1 == '6' ]; then
    docker run -d --name ES02 -p 9200:9200 -p 9300:9300 -e ES_JAVA_OPTS="-Xms256m -Xmx256m" \
        --restart=always elasticsearch:6.8.4
else
  echo 'invalid version args'
fi
