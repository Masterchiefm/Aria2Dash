#/bin/bash

while getopts ":p:p2:" opt
do
    case $opt in
        p)
        p=$OPTARG
        ;;
        p2)
        p2=$OPTARG
        ;;
    esac
done



#判断系统是debian，Ubuntu，Fedora，cent还是手机的turmux

if [[  $(command -v apt)  ]] ; then
        cmd="apt"
else
        cmd="yum"

fi



ip=$(curl -s https://ipinfo.io/ip)


#安装必要的包
$cmd update 
cmd2="$cmd install screen vim aria2 apache2 unzip git curl -y"
$cmd2

# 下载AriaNg
dir="/var/www/html"
tmp="/tmp/Onekey-deploy_aria2"
sudo rm -rf $tmp
sudo git clone https://github.com/Masterchiefm/Onekey-deploy_aria2.git $tmp
sudo sh $tmp/getariang
sudo rm -rf $dir/lixian
sudo rm -rf $dir/downloads
sudo mkdir -p $dir/lixian 
sudo mkdir -p $dir/downloads
sudo unzip $tmp/*.zip -d $dir/lixian
sudo chmod 777 -R $dir/lixian
link="<a href="$ip:8090" target="blank">"
echo $dir/lixian/head.html > $dir/lixian/index.html
echo $link >> $dir/lixian/index.html
echo $dir/lixian/foot.html > $dir/lixian/index.html

#安装FileBrowser
curl -fsSL https://filebrowser.xyz/get.sh | bash




#开始配置aria2
sudo rm -rf /root/.aria2
sudo mkdir -p /root/.aria2
sudo rm -rf /root/.aria2/*
sudo touch /root/.aria2/aria2.session
sudo mv /tmp/Onekey-deploy_aria2/aria2.conf /root/.aria2/
sudo mv /tmp/Onekey-deploy_aria2/updatetracker.sh /root/.aria2/
sudo rm -rf ./install.sh
clear
secret="rpc-secret=$p"
sudo echo $secret >> /root/.aria2/aria2.conf

#设置systemctl
sudo cp $tmp/aria2c /etc/init.d/
sudo cp $tmp/filebrowser /etc/init.d/
sudo chmod 777  /etc/init.d/aria2c
sudo chmod 777  /etc/init.d/filebrowser
sudo systemctl daemon-reload
sudo systemctl enable aria2c
sudo systemctl enable filebrowser
sudo service aria2c restart
sudo service filemanager restart
