# Aria2Dash: A Convenion Script for You to Quickly Deploy aria2 on Your Linux Server.


## About This
Aria2 is a command-line based multi-thread downloader, which supports http, metalink, Bt and many other download protocals. Most importantly, it can be controled remotely, making it possible for us to use it withou opening ssh client. 

However, its comman-line feature makes it difficult for most people to deploy it. When I want to use Aria on a new server, I had to spend plenty of time to configurate. What a wast of time! So I wrote this script to make it convient for my fist booting a new server.

## Features
1. Install [File Browser](https://filebrowser.xyz) defaultly. You can manage your files without opening ssh or ftp. The FileBrowser will be running on port 8080 defaultly. The default user and password are "admin".

2. Add Aria2c and FileBrowser to systemctl(service)，and the services will start automaticaly.

3. Auto-update BT-tracker each time the Aria2 starts, making it much more efficient for bt download. The scipt use this [tracker](https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all.txt)

4. Modified [AriaNg](https://github.com/mayswind/AriaNg) the Aria web manager, adding FileBrowser entrance and direct download path there. The default Aria2 RPC password is 1234, which can be set in the first time you run the script. 


## Installation

### 1. Install using default settings.
Copy the following command lines and run. If you are using Cent or Fedora, just change "apt" to "yum".

```
sudo apt install curl -y && bash <(curl -s -L https://github.com/Masterchiefm/Aria2Dash/raw/master/Aria2Dash.sh)
```

### 2. Install on a new server.
I would like to use Vultr's VPS to deploy Aria , for I can download some porn videos via BT and deleat the VPS after I download them to the local PC. So the popurs of the script is to deploy Aria when the VPS is initiated.

Just add a new boot script when you are going to deploy a new server. Vultr and Bandwagoon support this feture. What you need to do is to deleat all contents in the default boot script and pasty the following commands.
If you are using Cent or Fedora, just change "apt" to "yum".


```
#!/bin/bash

sudo apt install curl -y
 bash <(curl -s -L https://github.com/Masterchiefm/Aria2Dash/raw/master/Aria2Dash.sh)
 # Done！
```
Save the boot scipt and recheck your vps orders, do remenber to enable the scipt. Then deploy the server. 

### 3. Install with your own configulation
Download the scipt.
```
wget --no-check-certificate https://github.com/Masterchiefm/Aria2Dash/raw/master/Aria2Dash.sh
```
And run the scipt in "bash". Do notice that the scipt can be run in bash only! Not sh.
```
bash ./Aria2Dash.sh -a n -d /diretory/of/ariang -p YOUR_PASSWORD
```


-a can tell the scipt if you want to install Apache2 the web service. the default option is y(install it). In you don't, give the parameter "n".

-p is used to specify your Aria2 RPC password. The default password is "1234" if you don't use option "-p".

-d tells the script where your website directory is. For instance, Apache2 and Nginx's default derectory is /var/www/html . So, the script will put AriaNg to /var/www/html/ariang/, which means you can use it via http://yourip/ariang



This is an example:
If Jim doesn't want to install Apache2 because he has Nginx and had set Nginx's path to /var/web. Besides, he wants to set the password to "123456". So, he can just simply input the following:
```
bash ./Aria2Dash.sh -a n -d /var/web -p 1234567
```


## Launch aria2 or filebrowser
After the script compleating, it will launch aria2 and filebrowser's service and you don't need to launch them manualy. If you do want, use the following.

Login your server via ssh：
```
#Start service:
sudo service aria2 start
sudo service filebrowser start

#Restart service 
sudo service aria2 restart
sudo service filebrowser restart

#Monitor status
sudo service aria2 status
sudo service filebrowser status

#Stop service
sudo service aria2 stop
sudo service filebrowser stop
```

## Manage your files

You can manage all your files using file browser, which allows you delete, upload, share or edit files. Open your web browser and go to filebrowser using http://yourip:8080. The default user and password are "admin". Do remenber change them after you log in.



## My downloader:
[moqiqin.cn/ariang](https://moqiqin.cn/lixian)

Please click the "STAR" for me, Thank you!
