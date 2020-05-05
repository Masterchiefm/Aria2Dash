# Aria2Dash: A Convenion Script of Quickly Deploying aria2.
## About This
Aria2 is a command-line based multi-thread downloader, which supports http, metalink, Bt and many other download protocals. Most importantly, it can be controled remotely, making it possible for us to use it withou opening ssh client. 

However, its comman-line feature makes it difficult for most people to deploy it. When I want to use Aria on a new server, I had to spend plenty of time to configurate. What a wast of time! So I wrote this script to make it convient for my fist booting a new server.
[The full English version README is here](https://github.com/Masterchiefm/Aria2Dash/blob/master/README_en.md)


[小白请看这里](https://github.com/Masterchiefm/Aria2Dash/blob/master/README_easy.md) |or|[另一个文笔好的教程，什么值得买](https://post.smzdm.com/p/a6lrgdxe/)
# 一键脚本，设置带Web管理前端的Aria2下载工具

## 关于此脚本
Aria2是一个基于命令行的开源下载工具，支持除了ed2k以及迅雷之外的绝大多数下载方式。其多线程下载以及可以远程控制的特性，使其得到许多人的青睐。

然而，其缺点也明显，没有自带的图形管理，从而导致配置繁琐。本脚本就是为了解决这一问题而创作的。现已更新到2.0版，其性质与1.0完全不一样，只需要按最多两次回车键就能完成。对于将要购买新VPS的朋友，只需按照以下教程在初始化脚本中添加两行代码即可。

## 特色
```
1. 整合了[File Browser](https://filebrowser.xyz)的安装，使文件管理无需再通过ftp或者ssh进入服务器中操作。FileBrowser运行端口为8080,后期将考虑设为可修改。

2. 将Aria2c与FileBrowser添加进systemctl，并开机启动。

3. Aria2每次启动的时候会更新tracker，使bt下载更高效。tracker来源[tracker](https://raw.githubusercontent.com/ngosang/trackerslist)

4. 瞎改了[AriaNg](https://github.com/mayswind/AriaNg)网页管理界面，添加了FileBrowser的入口以管理文件，以及直接进入文件目录的入口。Aria2密钥默认为1234，可在安装时另外指定。输入http://你的ip/ariang  即可访问。

5. 每分钟刷新硬盘剩余容量,显示在网页根目录Disk_Usage.html中。网页能自动刷新。

6. 新增了控制管理面板
```


## 安装

### 1. 默认方式安装。
复制粘贴以下命令到终端，运行执行即可。全部参数采用默认设置。因cent8的源里无aria2，所以不能用。cent7可以，6也行


```
#Ubuntu用这个
sudo apt install curl -y && bash <(curl -s -L https://github.com/Masterchiefm/Aria2Dash/raw/master/Aria2Dash.sh)
```
```
#Fedora/cent用这个
sudo yum install curl -y && bash <(curl -s -L https://github.com/Masterchiefm/Aria2Dash/raw/master/Aria2Dash.sh)
```

若安装前已经使用了宝塔面板，则使用如下，并将/wwwroot/www.example.com 换为你宝塔面板显示的网站目录。
```
#Ubuntu用这个
sudo apt install curl -y && bash <(curl -s -L https://github.com/Masterchiefm/Aria2Dash/releases/download/2.2.0/install.sh) -a n -d /wwwroot/www.example.com
```
```
#Fedora/cent用这个
sudo yum install curl -y && bash <(curl -s -L https://github.com/Masterchiefm/Aria2Dash/releases/download/2.2.0/install.sh) -a n -d /wwwroot/www.example.com
```

直接运行命令即可完成安装。后期可通过在命令行中输入 aria2dash  来启动控制管理界面，可在此界面中修改密码等配置。
![管理面板截图](https://github.com/Masterchiefm/pictures/raw/master/Aria2Dash/%E7%AE%A1%E7%90%86%E9%9D%A2%E6%9D%BF.jpg)
![管理面板截图](https://github.com/Masterchiefm/pictures/raw/master/Aria2Dash/%E7%AE%A1%E7%90%86%E9%9D%A2%E6%9D%BF2.jpg)

### 2. 在部署服务器前设置以自动安装
以vultr为例。在deploy服务器前，找到script选项，添加一个新的boot脚本。删除原有内容，粘贴以下并保存。


```
#!/bin/bash
sudo apt install curl -y
 bash <(curl -s -L  https://github.com/Masterchiefm/Aria2Dash/raw/master/Aria2Dash.sh)
 # Done！这是Ubuntu的脚本
```

虽然本脚本可以在cent运行，但是cent8因为它的源里没有aria2c软件包，只能通过编译安装的方式安装aria2c，也就意味着安装时长高达半小时。不推荐使用。也许后期我会想想办法。而且cent的防火墙太难受了，头大。但是Fedora以及cent7是正常的，可以使用
```
#!/bin/bash
sudo yum install curl -y
 bash <(curl -s -L  https://github.com/Masterchiefm/Aria2Dash/raw/master/Aria2Dash.sh)
 # Done！这是Fedora/cent的脚本
```
保存后请再次检查服务器套餐设置，并记得勾选上脚本。点击deploy后，等待5分钟即可。


### 3. 高级安装。
先下载脚本。
```
#
wget --no-check-certificate https://github.com/Masterchiefm/Aria2Dash/raw/master/install.sh
#
```
然后运行。
```
#
bash ./install.sh -a n -d 网页目录 -p aria2密码
#
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
sudo systemctl start aria2

#重新启动
sudo systemctl restart aria2 

#查看状态
sudo systemctl status aria2
#关闭
sudo systemctl stop aria2 
```

## 管理文件

可以通过FileBrowser对服务器内的文件进行整理。FileBrowser可以删除，上传，分享，修改所有的文件。在浏览器中输入 http://你的ip:8080 即可进入。默认账号密码均为admin


## 例子
[moqiqin.cn/lixian](https://moqiqin.cn/ariang)

其实就是搞个脚本把一些乱七八糟的东西混杂一起，方便使用

