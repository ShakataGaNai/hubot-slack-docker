#!/bin/sh
sudo /usr/bin/redis-server /etc/redis/redis.conf 
/home/hubot/bin/hubot --adapter slack