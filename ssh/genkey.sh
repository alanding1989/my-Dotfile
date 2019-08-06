#! /usr/bin/env bash


rm ~/.ssh && ssh localhost || cd ~/.ssh && ssh-keygen -t rsa && cat ./id_rsa.pub >> ./authorized_keys

ssh-keygen -f "/home/alanding/.ssh/known_hosts" -R "localhost"
ssh-keygen -f "/home/alanding/.ssh/known_hosts" -R "0.0.0.0"
sudo ssh-keygen -f "/root/.ssh/known_hosts" -R "localhost"
sudo ssh-keygen -f "/root/.ssh/known_hosts" -R "0.0.0.0"
