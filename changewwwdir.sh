dir=$(cat wwwdir)
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
sudo echo "$link filebrowser" > $dir/filebrowser.html
sudo echo "</a>" >> $dir/filebrowser.html
echo "完成"
