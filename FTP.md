# FTP
Update the machine and install FTP server
```
apt update && apt -y upgrade
apt install vsftpd
```
Configure the `vsftpd.conf` in `/etc/vsftpd/`

* Uncomment this on the config file
```
anonymous_enable=NO
chroot_local_user=YES
```

* Add this config to the configuration file
```
allow_writeable_chroot=YES
pasv_enable=YES
pasv_min_port=1024
pasv_max_port=1048
write_enable=YES
```   

To start the FTP every time you boot the computer
```
systemctl enable vsftpd
```
Start FTP server 
```
systemctl start vsftpd 
```
Restart FTP server
```
systemctl restart vsftpd
```

