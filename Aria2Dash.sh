#!/bin/bash
#get the latest Aria2Dash
#用来获取Aria2Dash的最新版本，如果是fork我脚本的，请自行更改tag_name和script_url的链接。
tag_name="$(curl -s https://api.github.com/repos/Masterchiefm/Aria2Dash/releases/latest | grep -o '"tag_name": ".*"' | sed 's/"//g' | sed 's/tag_name: //g')"
script_url="https://github.com/Masterchiefm/Aria2Dash/releases/download/$tag_name/install.sh"
echo "the latest script is $script_url"
sudo apt install curl -y
curl -fsSL $script_url | bash
