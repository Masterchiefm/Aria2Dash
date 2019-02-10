#!/bin/bash
#简单脚本，快速在自己的VPS上部署离线下载利器。
clear
echo "本脚本仅运行于Ubuntu、Deepin、Debian等基于Debian的Linux操作系统上"
echo "本脚本目的："
echo " 搭建基于 Aria2 ，并且能使用网页管理器AriaNg进行下载管理的下载平台"
echo " 主要拿来离线下载，挂机下完东西再取回美滋滋"
echo
echo "注意事项："
echo " 操作系统为上述系统，并推荐部署于境外VPS中，国内的价格过高"
echo " 注意VPS服务商是否对版权敏感，有些不许下盗版BT资源"
echo " 确保买的VPS空间足够装以后你要下载东西"
echo " 本程序同样可以用在非服务器的普通电脑上"
echo
echo "准备开始安装。将要安装以下程序以及其依赖程序："
echo " Aria2，用以下载； AriaNg 用以提供网页版管理工具； Apache2，开启网页服务器以及文件服务器 ；vim，文本编辑器，有需要的时候用以改配置文件"
echo "我已知晓风险并确认进行部署。按回车继续。若不知道风险，自行百度。"
read
echo "开始咯！"
# Update
sudo apt update -y
# 安装必要程序
sudo apt-get install vim aria2 apache2 unzip screen git -y
# 下载AriaNg
sudo rm -rf /tmp/Onekey-deploy_aria2
sudo git clone https://github.com/Masterchiefm/Onekey-deploy_aria2.git /tmp/Onekey-deploy_aria2
sudo sh /tmp/Onekey-deploy_aria2/getariang
sudo rm -rf /var/www/html/lixian
sudo mkdir -p /var/www/html/lixian 
sudo unzip /tmp/Onekey-deploy_aria2/*.zip -d /var/www/html/lixian
sudo chmod 777 -R /var/www/html/lixian
#添加启动入口
sudo rm -rf ~/Start_Aria.sh
sudo cp /tmp/Onekey-deploy_aria2/Start* ~/
sudo chmod 777 ~/Start_Aria.sh
sudo rm -rf /root/Start_Aria.sh
sudo cp /tmp/Onekey-deploy_aria2/Start* /root
sudo chmod 777 /root/Start_Aria.sh
#配置密码
sudo sh /tmp/Onekey-deploy_aria2/setpasswd




