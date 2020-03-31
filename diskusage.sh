
#一分钟刷新一次
 echo "<!doctype html><head><meta charset=UTF-8><meta http-equiv=refresh content=0;url=/Disk_Usage.html></head>"
 echo "<!doctype html><head><meta charset="UTF-8"><meta http-equiv=refresh content=20;url=/Disk_Usage.html></head> <br>" > $file
date >>$file
echo "<br>" >>$file
echo "<br>" >>$file
echo "----------------------------------------------" >>$file
echo "<br>" >>$file
df -h |grep Used >>$file
echo "<br>" >>$file
df -h |grep G >>$file
echo "<br>" >>$file
#df -h |grep hell >>$file
