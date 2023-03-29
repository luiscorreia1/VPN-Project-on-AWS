Install ftp
```
apt install vsftpd
```
start ftpd 
```
systemctl start vsftpd 
```

to start the ftp every time you boot the pc 
```
systemctl enable --now vsftpd
```



config file location 
```
/etc/vsftpd/vsftpd.conf
```
uncomment this on the config file 
```
anonymous_enable=NO
chroot_local_user=YES
```

add to the config file 
```
allow_writeable_chroot=YES
pasv_enable=YES
pasv_min_port=1024
pasv_max_port=1048
write_enable=YES
```   
   # systemctl restart vsftpd
