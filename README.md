# Script of Onekey-deploy aria2
# 一键脚本，设置带Web管理前端的Aria2下载工具
本脚本用来一键安装Aria2以及完成包括配置AriaNg在内的一系列后续配置
仅运行于ubuntu等基于Debian的系统上。Cent OS等系统可以自行修改release中的文件，仅将apt修改为yum然后运行即可
## 安装
复制并在终端中输入以下代码，回车运行。
```
sudo rm -rf ./install* && wget https://github.com/Masterchiefm/Onekey-deploy_aria2/releases/download/1.0.2/install.sh && sh ./install.sh
```
按照说明配置即可

## 启动
ssh 登录进终端后，在家目录中有一个Start_Aria.sh文件。输入以下运行（注意大小写）
```
sh Start_Aria.sh
```
运行后按 Ctrl + a + d 放入后台，进入后台后可以退出终端或者输入以下重新显示。按 Ctrl + c 退出。
```
screen -r
```
显示至少有一个绿色提示即可


## 使用
### 部署在服务器：
进入下载管理
在浏览器地址栏中输入以下：
```
http://ip地址(或者域名)/lixian 
```
例如：http://moqiqin.cn/lixian 或者 htttp://127.0.0.1/lixian
![示意图](https://moqiqin.cn/wp-content/uploads/2019/02/ariang.png)
取回文件
在网页中点击”取回文件“或者访问
```
http://ip地址/downloads 
```
### 部署在自己电脑：
将上述的ip改为localhost即可

## 管理
要删除下完的东西，只有以下方法：
通过 ssh 访问。文件全部下载在 /var/www/html/downloads 中，请自行
```
cd /var/www/html/downloads
```
ls 列出所有文件，rm -rf * 删除所有文件
或者自行配置ftp访问、管理。


## 例子
[moqiqin.cn](http://moqiqin.cn/lixian)

其实就是搞个脚本把下面两个东西凑在一起用。
[AriaNg](https://github.com/mayswind/AriaNg) 和 [Aria2](https://github.com/aria2/aria2)


