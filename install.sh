#/bin/bash
sudo rm -rf ./install.sh
cd /

#Aria2密码
p=1234

#是否安装Apache2
a=y

#默认网页路径
dir="/var/www/html"
d=$dir

if [ $d != $dir ] ; then
    dir=$d
    echo !
fi


while getopts ":p:a:d:h:" opt
do
    case $opt in
        p)
        p=$OPTARG
        ;;
        a)
        a=$OPTARG
        ;;
        d)
        d=$OPTARG
        ;;
        h)
        h=$OPTARG
        ;;
        ?)
        echo "WTF???"
        exit 
        ;;
    esac
done



#判断系统是debian，Ubuntu，Fedora，cent还是手机的turmux

if [[  $(command -v sudo apt)  ]] ; then
        cmd="sudo apt"
else
        cmd="sudo yum"

fi


#安装必要的包
$cmd update 
#根据需要，安装Apache2
if [ $a = "y" ] ; then
    cmd1="$cmd install apache2 -y"
    $cmd1
    sudo mv $dir/index.html $dir/index.html0
else  
    echo "I will not install apache2."
fi

#安装必要的
cmd2="$cmd install screen vim aria2 unzip git curl -y"
$cmd2

# 下载AriaNg

tmp="/tmp/Aria2Dash"
sudo rm -rf $tmp
sudo git clone https://github.com/Masterchiefm/Aria2Dash.git $tmp
sudo rm -rf $dir/ariang
sudo rm -rf $dir/downloads
sudo mkdir -p $dir/ariang
sudo mkdir -p $dir/downloads
sudo unzip $tmp/*.zip -d $dir/ariang
sudo chmod 777 -R $dir/ariang
link="<a href="http://$ip:8080/files/var/www/html" target="blank">"
cat $dir/ariang/head.html > $dir/ariang/index.html
echo $link >> $dir/ariang/index.html
cat $dir/ariang/foot.html >> $dir/ariang/index.html
#sudo rm -rf $dir/index.html

#沃日，为啥一直bug。。。
ip=$(curl -s https://ipinfo.io/ip)
dir="/var/www/html"
link="<a href="http://$ip:8080/files/var/www/html" target="blank">"
sudo cat $dir/ariang/head.html > $dir/ariang/index.html
sudo echo $link >> $dir/ariang/index.html
sudo cat $dir/ariang/foot.html >> $dir/ariang/index.html
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
sudo update-rc.d   filebrowser   enable

sudo update-rc.d   aria2c  enable


sudo service aria2c restart
sudo service filebrowser restart
