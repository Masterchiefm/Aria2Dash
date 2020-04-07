#/bin/bash

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
    
    #log,安装日志，保存于/root/log_of_install_aria2dash.log
    log="/root/log_of_install_aria2dash.log"
    date > $log
    

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
echo "ariang directory is $dir" >> $log


echo "判断系统是debian，Ubuntu，Fedora，cent"

if [[  $(command -v apt)  ]] ; then
        cmd="sudo apt"
	echo "your system is Ubuntu/Debian" >>$log
	apache2="apache2"
else
        cmd="sudo yum"
	
	yum -y install epel-release
	yum -y install aria2
	apache2="httpd"
        firewall-cmd --zone=public --add-port=80/tcp --permanent  #cent的防火墙有时候很恶心
	
	#cent8 不能直接安装aria2，fedora和cen7却可以。真是醉了。以下是编译安装，安装时长高达半小时。醉了。
	#wget https://github.com/aria2/aria2/releases/download/release-1.35.0/aria2-1.35.0.tar.gz
	#tar -zxvf aria2-1.35.0.tar.gz
	#cd aria2-1.35.0
	#yum install gcc* -y
	#./configure 
	#make
	#make install
	

fi

###############################安装必须的包#################################
echo "Updatting..."
$cmd update -y
echo "根据需要，安装Apache2或者httpd"
if [ $a = "y" ] ; then
	echo "安装$apache2"
    cmd1="$cmd install $apache2 -y"
    $cmd1
    sudo mv $dir/index.html $dir/index.html0
    systemctl restart $apache2 
else  
    echo "you choosed not to install apache2/httpd."
    
fi

touch $dir/Aria2Dash_is_installing
#其实screen，vim可以不用。。但是我为了自己方便就加上了
cmd2="$cmd install screen vim  unzip git curl -y"
$cmd2
#以防万一，每个包单独安装
cmd3="$cmd install vim  -y"
$cmd3

cmd3="$cmd install unzip  -y"
$cmd3
if [[  $(command -v unzip)  ]] ; then
	echo "installed unzip" >>$log
else
	echo "install unzip failed">>$log
fi

cmd3="$cmd install git  -y"
$cmd3
if [[  $(command -v git)  ]] ; then
	echo "installed git" >>$log
else
	echo "install git failed">>$log
fi

cmd3="$cmd install curl  -y"
$cmd3
if [[  $(command -v curl)  ]] ; then
	echo "installed curl" >>$log
else
	echo "install curl failed">>$log
fi

cmd3="$cmd install aria2  -y"
$cmd3
if [[  $(command -v aria2c)  ]] ; then
	echo "installed aria2" >>$log
else
	echo "install aria2 failed">>$log
fi
###############################安装必须的包####################################

###############################配置网页管理端AriaNG#############################
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
ip=$(curl -s https://ipapi.co/ip)
echo "你的公网ip是$ip"
link="<a href="http://$ip:8080" target="blank">"
sudo cat $dir/ariang/head.html > $dir/ariang/index.html
sudo echo $link >> $dir/ariang/index.html
sudo cat $dir/ariang/foot.html >> $dir/ariang/index.html
sudo echo "$link filebrowser" >> $dir/filebrowser.html
sudo echo "</a>" >> $dir/filebrowser.html
###############################配置网页管理端AriaNG#############################


###############################安装filebrowser#####################################
echo "安装FileBrowser,如果国内服务器安装卡在这里，请ctrl + c 退出并参考高级安装，使用 -f n 跳过这一步安装。"
if [ $f = "y" ]  ;  then
    bash $tmp/get-filebrowser.sh #因为最新版有无法编辑文件的bug，所以改了脚本，只装旧版
    sudo cp $tmp/filebrowser /etc/init.d/
    sudo chmod 755  /etc/init.d/filebrowser
    sudo systemctl daemon-reload
    	if [[  $(command -v apt)  ]] ; then
         sudo update-rc.d filebrowser defaults #Ubuntu用这个
	 sudo systemctl restart filebrowser
	else
	firewall-cmd --zone=public --add-port=8080/tcp --permanent
        sudo chkconfig filebrowser on #Cent OS用这个
	sudo systemctl restart filebrowser
	fi
    if [[  $(command -v filebrowser)  ]] ; then
	echo "installed filebrowser" >>$log
    else
	echo "无法安装filebrowser，可能因为国内网络问题无法访问git导致">>$log
    fi
   
    
else
    echo "not isntall FileBrowser">>$log
fi
###############################安装filebrowser#####################################


###############################aria2配置文件修改#####################################
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
	systemctl restart firewalld.service
fi



sudo systemctl restart aria2c

###############################aria2配置文件修改#####################################

###############################Crontab设置###############################
#显示硬盘容量
	setting="* * * * * bash /root/.aria2/diskusage.sh"
	
	echo "${setting}"
	crontab="/var/spool/cron/crontabs/root"
	
	#file指网页显示硬盘容量的html文件
	file="file=$dir/Disk_Usage.html"
	
	touch /root/.aria2/diskusage.sh
	echo $file > /root/.aria2/diskusage.sh
	sudo chmod 777 /root/.aria2/diskusage.sh
	#diskusage.sh里会引用到file，该sh会将执行结果输出到file中
	cat /tmp/Aria2Dash/diskusage.sh >>  /root/.aria2/diskusage.sh
	echo "${setting}" >> $crontab
	systemctl restart cron
###############################Crontab设置###############################	


###############################控制面版#############################
sudo rm -rf /etc/aria2dash
sudo mkdir /etc/aria2dash
mv $tmp/aria2dash.py /etc/aria2dash
mv $tmp/changewwwdir.sh /etc/aria2dash
sudo echo $dir > /etc/aria2dash/wwwdir
sudo touch /usr/bin/aria2dash
sudo echo "python3 /etc/aria2dash/aria2dash.py" > /usr/bin/aria2dash
sudo chmod 777 /usr/bin/aria2dash
source ~/.bashrc
###############################控制面版#############################
rm $dir/Aria2Dash_is_installing
echo "==============================================================="
cat $log
echo "==============================================================="
echo "Commands:"
echo "在终端中直接输入aria2dash即可进入控制面板，有修改密码等功能"
echo "可以用systemctl stop aria2c 等方式单个关闭aria2或者filebrowser"

