#!/bin/bash
#get the latest Aria2Dash
api="https://api.github.com/repos/Masterchiefm/Aria2Dash/releases/latest"
tag_name="$(curl -s https://api.github.com/repos/Masterchiefm/Aria2Dash/releases/latest | grep -o '"tag_name": ".*"' | sed 's/"//g' | sed 's/tag_name: //g')"
script_url="https://github.com/Masterchiefm/Aria2Dash/releases/download/$tag_name/install.sh"
echo "the latest script is $script_url"
sudo apt install curl -y
curl -fsSL $script_url | bash
