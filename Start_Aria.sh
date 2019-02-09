#!/bin/bash
bash /root/ss-fly/ss-fly start
screen -S aria aria2c --conf-path=/root/.aria2/aria2.conf
