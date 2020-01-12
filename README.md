# Aria2Dash: A Convenion Script of Quickly Deploying aria2.
## About This
Aria2 is a command-line based multi-thread downloader, which supports http, metalink, Bt and many other download protocals. Most importantly, it can be controled remotely, making it possible for us to use it withou opening ssh client. 

However, its comman-line feature makes it difficult for most people to deploy it. When I want to use Aria on a new server, I had to spend plenty of time to configurate. What a wast of time! So I wrote this script to make it convient for my fist booting a new server.
[The full English version README is here](https://github.com/Masterchiefm/Aria2Dash/blob/master/README_en.md)


[小白请看这里](https://github.com/Masterchiefm/Aria2Dash/blob/master/README_easy.md)
# 一键脚本，设置带Web管理前端的Aria2下载工具

## 关于此脚本
Aria2是一个基于命令行的开源下载工具，支持除了ed2k以及迅雷之外的绝大多数下载方式。其多线程下载以及可以远程控制的特性，使其得到许多人的青睐。

然而，其缺点也明显，没有自带的图形管理，从而导致配置繁琐。本脚本就是为了解决这一问题而创作的。现已更新到2.0版，其性质与1.0完全不一样，只需要按最多两次回车键就能完成。对于将要购买新VPS的朋友，只需按照以下教程在初始化脚本中添加两行代码即可。

## 特性
1. 整合了[File Browser](https://filebrowser.xyz)的安装，使文件管理无需再通过ftp或者ssh进入服务器中操作。FileBrowser运行端口为8080,后期将考虑设为可修改。

2. 将Aria2c与FileBrowser添加进systemctl，并开机启动。

3. Aria2每次启动的时候会更新tracker，使bt下载更高效。tracker来源[tracker](https://raw.githubusercontent.com/ngosang/trackerslist)

4. 瞎改了[AriaNg](https://github.com/mayswind/AriaNg)网页管理界面，添加了FileBrowser的入口以管理文件，以及直接进入文件目录的入口。Aria2密钥默认为1234，可在安装时另外指定。输入http://你的ip/ariang  即可访问。


## 安装

### 1. 默认方式安装。
复制粘贴以下命令到终端，运行执行即可。全部参数采用默认设置。

cent或者fedora请将apt改yum，脚本写的时候考虑过这些系统。但是未测试，理论上来说可以用。
```
sudo apt install curl -y && bash <(curl -s -L https://github.com/Masterchiefm/Onekey-deploy_aria2/releases/download/2.0.3/install.sh)
```

### 2. 在部署服务器前设置以自动安装
以vultr为例。在deploy服务器前，找到script选项，添加一个新的boot脚本。删除原有内容，粘贴以下并保存。

cent或者fedora请将apt改yum，脚本写的时候考虑过这些系统。但是未测试，理论上来说可以用。
```
#!/bin/bash

sudo apt install curl -y
 bash <(curl -s -L https://github.com/Masterchiefm/Onekey-deploy_aria2/releases/download/2.0.3/install.sh)
```
保存后请再次检查服务器套餐设置，并记得勾选上脚本。点击deploy后，等待5分钟即可。

### 3. 高级安装。
先下载脚本。
```
wget https://github.com/Masterchiefm/Onekey-deploy_aria2/releases/download/2.0.3/install.sh
```
然后运行。
```
bash ./install.sh -a n -d 网页目录 -p aria2密码
```
注意，只能用bash，不可以用sh。

参数-a 表示是否安装apache2网页服务。默认值为安装，不安装就n。

参数-d 用来指定网站安装路径。默认情况下,Apache2和Nginx都是读取放在 /var/www/html 下的网页。所以本脚本默认值也是这里。如果你的网站是其他目录，请自行修改。

参数-p 用来指定Aria2的密钥。脚本提供的默认密码为1234。你也可以安装后进入/root/.aria2/aria2.conf修改。修改后重新运行aria2即可。

例如以下命令:
```
bash ./install.sh -a n -d /var/web -p 1234567
```
意思是不安装apache2，指定将AriaNg放入/var/web内，设置Aria2的RPC密钥为1234567



## 启动
脚本运行完成后，aria2与filebrowser均已自动启动。当然你也可以日后对其运行状态进行调整。
ssh 登录进终端后，输入：
```
#启动
sudo service aria2 start

#重新启动
sudo service aria2 restart

#查看状态
sudo service aria2 status

#关闭
sudo service aria2 stop
```

## 管理文件

可以通过FileBrowser对服务器内的文件进行整理。FileBrowser可以删除，上传，分享，修改所有的文件。在浏览器中输入 http://你的ip:8080 即可进入。默认账号密码均为admin


## 例子
[moqiqin.cn/lixian](https://moqiqin.cn/lixian)

其实就是搞个脚本把下面两个东西凑在一起用。


