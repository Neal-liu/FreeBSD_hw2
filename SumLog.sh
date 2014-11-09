#!/bin/csh

set da = "~/hw2/date"
set temp = "~/hw2/temp"
set sum = "~/hw2/sum_log"
set s = "<< Failed/Invaid Login >>"
set month = `date "+%b"`
set day = `date "+%d"`

test -e logs
if($? == 1) then
    mkdir logs
endif

date > $da
set month1 = `awk -F " " '{print $2$3}' $da`

awk -F " " '{print $2 "-" $3 "-" $6 " System Log :"}' $da > $sum
echo >> $sum
set login = "~/hw2/logs/$month-$day-failed_login_log"
echo $s > $login
echo >> $login
echo "==== Illegal Users ====" >> $login
cat /var/log/messages | grep illegal > $temp
awk -F " " '{ if ("'$month1'" == $1$2) print $1 " " $2 " " $3 " " $13" "$14" "$15}' $temp >> $login
echo "==== Failed Users ====" >> $login
/bin/cat /var/log/messages | grep error | grep -v illegal > $temp
awk -F " " '{if("'$month1'" == $1$2) print $1 " " $2 " " $3 " " $11" "$12" "$13}' $temp >> $login
cat $login >> $sum

set users = "~/hw2/logs/$month-$day-users_login_log"
echo > $users
echo "<< User Login >>" >> $users
last | grep -v utx.log > $temp
awk -F " " '{if(NF > 6 && "'$day'"~$6) print $0}' $temp >> $users
cat $users >> $sum

set disk = "~/hw2/logs/$month-$day-harddisk_usage_log"
echo > $disk
echo "<< Hard Disk usage >>" >> $disk
df -h >> $disk
cat $disk >> $sum

set setuid = "~/hw2/logs/$month-$day-setuid_diff_log"
echo > $setuid
echo "<< Difference of setuid programs >>" >> $setuid
#find / -type f -perm -4000 -ls >> $setuid
diff /var/log/setuid.today /var/log/setuid.yesterday >> $setuid
cat $setuid >> $sum


#delete logs after three days
find ~/hw2/logs/ -mtime +3 -type f -exec rm -rf {} \;


