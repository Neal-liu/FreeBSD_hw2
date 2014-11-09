#!/bin/tcsh

set da = "date"

date > $da
set t1 = ` awk -F " " '{print $2 $3}' $da `
set t2 = ` awk -F " " '{print $4}' $da | awk -F ":" '{print $1 $2}' `

tar -czf ~/hw2/backup/$t1-$t2-mail.tar /var/mail
tar -czf ~/hw2/backup/$t1-$t2-home.tar /home
tar -czf ~/hw2/backup/$t1-$t2-etc.tar  /etc
tar -czf ~/hw2/backup/$t1-$t2-local_etc.tar    /usr/local/etc

#在 7 天以前有修改過的檔案，例如今天是6/10，則7天6/4 以前的檔案都列出
#find ./ -mtime +7

find ~/hw2/backup/ -mtime +3 -type f -exec rm -rf {} \;
# delete file which built before 6 hours ago.
#find ~/hw2/backup/ -mmin +360 -type f -exec rm -rf {} \;

# delete file which built in 10 minutes
#find ~/hw2/backup/ -mmin -10 -type f -exec rm -rf {} \;

rsync -avz ~/hw2/backup/$t1-$t2-mail.tar hunter0hunter04@140.116.245.72:backup/neal/
rsync -avz ~/hw2/backup/$t1-$t2-home.tar hunter0hunter04@140.116.245.72:backup/neal/
rsync -avz ~/hw2/backup/$t1-$t2-etc.tar hunter0hunter04@140.116.245.72:backup/neal/
rsync -avz ~/hw2/backup/$t1-$t2-local_etc.tar hunter0hunter04@140.116.245.72:backup/neal/

