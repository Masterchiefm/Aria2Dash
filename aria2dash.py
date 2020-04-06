#!/usr/bin/env python
# coding: utf-8

# In[16]:


from os import popen
from os import system


# In[17]:


def main_page():
    
    print ("=====================Aria2Dash 控制面板=======================")
    print( """

        1. 修改Aria2Dash密码
        2. 更改Aria2默认下载路径
        3. 更改AriaNg存放路径
        4. aria2运行状态
        5. FileBrowser 运行状态
        6. 退出
        
        """)
    print ("=====================Aria2Dash 控制面板=======================")   
    opt = int(input ("输入选项:"))

    return opt


# In[18]:


def opt1():
    system('clear')
    passwd = input ("输入新的Aria2密码:")
    
    #用变量f存储源文件
    f = ""
    
    #a表示找到含有关键词key的这一行
    a = 0
    
    dir = "/root/.aria2/aria2.conf"
    key = "rpc-secret="
    
    #打开dir，将内容逐行读取到f，有key的行就把这一行改密码
    f0 = open(dir,'r', encoding='UTF-8')
    for line in f0:
        if passwd == "":
            key ="#rpc-secret="
        if "rpc-secret=" in line:
            line = key + passwd + "\n"
            f = f + line 
            a = a + 1
            #print (line)
        else:
            f = f + line
            a = a + 0
            #print (line)
            
    
    if a == 0:
        line = key + passwd
        f = f + line + "\n"
    
    f0.close
    
    #显示整个f，然后写入dir
    print (f)
    f0 = open(dir,'w')
    f0.write(f)
    f0.close
    out = popen('systemctl restart aria2c').read()
    print ("""已更改""")
    return 1


# In[19]:


def opt2():
    popen('clear')
    n_dir = input ("输入新的Aria2默认下载路径:")
    f = ""
    a = 0
    dir = "/root/.aria2/aria2.conf"
    key = "dir="
    f0 = open(dir,'r', encoding='UTF-8')
    for line in f0:
        while n_dir == "":
            print ("错误！不能留空")
            n_dir = input ("输入新的Aria2默认下载路径:")
            
        if key in line:
            print ('原始下载路径为：' ,line[4:])
            line = key + n_dir + "\n"
            f = f + line 
            a = a + 1
            print ('修改过后的下载路径为：',line[4:1])
            #print (line)
        else:
            f = f + line
            a = a + 0
            #print (line)
            
    
    if a == 0:
        line = key + n_dir + "\n"
        f = f + line
    
    f0.close
    print (f)
    f0 = open(dir,'w')
    f0.write(f)
    f0.close
    out = popen('systemctl restart aria2c').read()
    print ("""已更改""")
    return 1


# In[20]:


def opt3():

    f = open('wwwdir')
    dir0 = f.read()
    f.close
    print ('原AriaNg路径为' + " " + dir0 +  " " +"目录下的ariang")
    n_dir = input(" 输入新的目录，你的ariang将会放在该目录下的ariang文件夹内.\n")
    f = open('wwwdir','w')
    f.write(n_dir)
    f.close
    a=popen('bash /etc/Aria2Dash/changewwwdir.sh').read()
    for line in a.splitlines():
        print (line)
    return 1


# In[21]:


def opt4():

    out = popen('systemctl status aria2c').read()
    statu1=str("""(running)""")
    statu2=str("""(exited)""")
    statu=0
    if statu1  in out:
        statu=statu + 1
    if statu2  in out:
        statu=statu + 1
    
    if statu == 0:
        print ('aria2未运行')
    else:
        print('aria2已运行')
        
    opt = input (" a. 重启aria2\n b. 停止aria2 \n c. 查看status \n d. 退出 \n\n 输入选择：")
    if opt == 'a':
        out = popen('systemctl restart aria2c').read()
        print ("""========================Aria2 Status=========================""")
        for line in out.splitlines():
            print(line)
        opt4()
    elif opt == 'b':
        out = popen('systemctl stop aria2c').read()
        print ("""========================Aria2 Status=========================""")
        for line in out.splitlines():
            print(line)
        opt4()
    elif opt == 'c':
        out = popen('systemctl status aria2c').read()
        print ("""========================Aria2 Status=========================""")
        for line in out.splitlines():
            print(line)
        opt4()    
    return 1


# In[22]:


def opt5():

    out = popen('systemctl status filebrowser').read()
    
    statu1=str("""(running)""")
    statu2=str("""(exited)""")
    statu=0
    if statu1  in out:
        statu=statu + 1
    if statu2  in out:
        statu=statu + 1
    
    if statu == 0:
        print ('filebrowser未运行')
    else:
        print ('filebrowser已运行')
        
    opt = input (" a. 重启filebrowser\n b. 停止filebrowser \n c. 查看status \n d. 退出 \n\n 输入选择：")
    if opt == 'a':
        out = popen('systemctl restart filebrowser').read()
        print ("""========================filebrowser Start=========================""")
        for line in out.splitlines():
            print(line)
        opt5()
    elif opt == 'b':
        out = popen('systemctl stop filebrowser').read()
        print ("""========================filebrowser Status=========================""")
        for line in out.splitlines():
            print(line)
        opt5()
    elif opt == 'c':
        out = popen('systemctl status filebrowser').read()
        print ("""========================filebrowser Status=========================""")
        for line in out.splitlines():
            print(line)
        opt5()   
    return 1


# In[23]:


def process():
    
    opt = main_page()

    if opt == 1:
        #print (opt)
        a = opt1()
    elif opt ==2:
        a = opt2()
    elif opt ==3:
        a = opt3()
    elif opt ==4:
        a = opt4()
    elif opt ==5:
        a = opt5()
    elif opt ==6:
        a = 0
    return a
        


# In[ ]:


a = 1
while a :
    a = process()


# In[ ]:




