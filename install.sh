#/bin/bash
#Verion:2.1.1
sudo rm -rf ./Aria2Dash.sh
cd /

#预设变量
    #Aria2密码
    p=1234
    
    #是否安装Apache2
    a=y

    #默认网页路径
    dir="/var/www/html"
    d=$dir #预先给d赋值，免得下面要是不输入东西的话判断报错
    
    #filebrowser,因为GFW，国内VPS可能装不上,默认是可以装
    f=y
    
while getopts ":p:a:d:f:h:" opt
do
    case $opt in
        #aria2自定密码
        p)
        p=$OPTARG
        ;;
        #是否安装apache/httpd
        a)
        a=$OPTARG
        ;;
        #指定网页根目录
        d)
        d=$OPTARG
        ;;
        #是否安装filebrowser，国内建议不装
        f)
        f=$OPTARG
        ;;
        #帮助，暂时不搞
        h)
        h=$OPTARG
        ;;
        ?)
        echo "WTF???"
        exit 
        ;;
    esac
done

#若用户输入网页根目录与预设不一致，则将dir变量值改为用户设置的
if [ $d != $dir ] ; then
	echo "d!=dir"
	dir=$d
fi

echo "判断系统是debian，Ubuntu，Fedora，cent还是手机的turmux（咕）"

if [[  $(command -v apt)  ]] ; then
        cmd="sudo apt"
	echo "Ubuntu/Debian"
	apache2="apache2"
else
        cmd="sudo yum"
	echo "Cent OS"
	apache2="httpd"
        firewall-cmd --zone=public --add-port=80/tcp --permanent  #cent的防火墙有时候很恶心

fi


echo "Updatting..."
$cmd update -y
echo "根据需要，安装Apache2或者httpd"
if [ $a = "y" ] ; then
	echo "安装$apache2"
    cmd1="$cmd install $apache2 -y"
    $cmd1
    sudo mv $dir/index.html $dir/index.html0
    systemctl reload $apache2 
else  
    echo "I will not install apache2."
fi

#其实screen，vim可以不用。。但是我为了自己方便就加上了
cmd2="$cmd install screen vim  unzip git curl -y"
$cmd2
cmd3="$cmd install vim  -y"
$cmd3
cmd3="$cmd install unzip  -y"
$cmd3
cmd3="$cmd install git  -y"
$cmd3
cmd3="$cmd install curl  -y"
$cmd3
cmd3="$cmd install aria2  -y"
$cmd3


echo "下载AriaNg"
tmp="/tmp/Aria2Dash"
sudo rm -rf $tmp
sudo rm -rf $dir/ariang
sudo rm -rf $dir/downloads

sudo git clone https://github.com/Masterchiefm/Aria2Dash.git $tmp
sudo mkdir -p $dir/ariang 
sudo mkdir -p $dir/downloads
sudo unzip $tmp/*.zip -d $dir/ariang
sudo chmod 777 -R $dir/ariang

echo "正在获取服务器ip，然后填入AriaNg"
ip=$(curl -s https://ipinfo.io/ip)
link="<a href="http://$ip:8080" target="blank">"
sudo cat $dir/ariang/head.html > $dir/ariang/index.html
sudo echo $link >> $dir/ariang/index.html
sudo cat $dir/ariang/foot.html >> $dir/ariang/index.html
sudo echo $link >> $dir/filebrowser.html

echo "安装FileBrowser,如果国内服务器安装卡在这里，请重新运行并使用 -f n 跳过这一步安装。"
if [ $f = "y" ]  ;  then
    bash $tmp/get-filebrowser.sh
    sudo cp $tmp/filebrowser /etc/init.d/
    sudo chmod 755  /etc/init.d/filebrowser
    sudo systemctl daemon-reload
    	if [[  $(command -v apt)  ]] ; then
         sudo update-rc.d filebrowser defaults #Ubuntu用这个
	 sudo systemctl restart filebrowser
	else
        sudo chkconfig filebrowser on #Cent OS用这个
	sudo systemctl restart filebrowser
	fi
   
    
else
    echo "不安装FileBrowser"
fi

echo "开始配置aria2"
sudo rm -rf /root/.aria2
sudo mkdir -p /root/.aria2
sudo touch /root/.aria2/aria2.session
sudo mv /tmp/Aria2Dash/aria2.conf /root/.aria2/
sudo mv /tmp/Aria2Dash/updatetracker.sh /root/.aria2/
sudo rm -rf ./install.sh

secret="rpc-secret=$p"
sudo echo $secret >> /root/.aria2/aria2.conf

echo "设置systemctl"
sudo cp $tmp/aria2c /etc/init.d/
sudo chmod 755  /etc/init.d/aria2c
sudo systemctl daemon-reload

if [[  $(command -v apt)  ]] ; then
        sudo update-rc.d aria2c defaults #Ubuntu用这个
	echo "Ubuntu/Debian"
else
        sudo chkconfig aria2c on #Cent OS用这个
	echo "Cent OS"
        firewall-cmd --zone=public --add-port=6800/tcp --permanent  #cent的防火墙有时候很恶心

fi



sudo systemctl restart aria2c


