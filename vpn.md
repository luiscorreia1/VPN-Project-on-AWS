# VPN
Site to site server configuration example: [server-ss.conf](server-ss.conf)
<br>
Site to site client configuration example: [server-ss-cli.conf](server-ss-cli.conf) 
<br>
Remote access configuration example: [server-ra.conf](server-ra.conf)

Install the vpn and easy-rsa:
```
apt install openvpn easy-rsa
```
Create the certs you are going to need:
<br>
* Easy-rsa:
```
cd /etc
cp -R /usr/share/easy-rsa/ .
cd easy-rsa/
./easyrsa init-pki
./easyrsa build-ca nopass
./easyrsa build-server-full vpnsrv.enta.pt nopass
./easyrsa build-clint-full vpncli.enta.pt nopass
./easyrsa --subject-alt-name="DNS:www.enta.pt" sign-req server www.enta.pt
```
* Openvpn:
```
cd /etc/openvpn/   
openssl dhparam -out dh2048.pem 2048
openvpn --genkey --secret ta.key
```    
Copy the easy-rsa certs to the vpn folder: 
```
cp /etc/easy-rsa/pki/issued/vpncli.enta.pt.crt /etc/openvpn/
cp /etc/easy-rsa/pki/private/vpncli.enta.pt.key /etc/openvpn/
cp /etc/easy-rsa/pki/issued/vpnsrv.enta.pt.crt /etc/openvpn/
cp /etc/easy-rsa/pki/private/vpnsrv.enta.pt.key /etc/openvpn/
cp /etc/easy-rsa/pki/ca.crt /etc/openvpn/
cp /etc/easy-rsa/pki/private/ca.key /etc/openvpn/
```
Copy server and client sample:
```
cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf /etc/openvpn/  
cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf /etc/openvpn/  
```
Make a copy of the server sample:
```
cp server.conf server-ss.conf      #for site to site 
cp server.conf server-ss-cli.conf  #for the site to site cli 
cp server.conf server-ra.conf      #for remote acess 
```   
   
To activate the vpn:   
```
systemctl enable openvpn@server-ra
systemctl start openvpn@server-ra
systemctl enable openvpn@server-ss
systemctl server openvpn@server-ss
```
Check if the port of the vpn are open 
```
netstat -nulp
```   
Edit the client config that is use to connect to the server:
```
nano /etc/openvpn/client.conf 
```     
# Client
For the client the only thinks you need to do is 
<br>
Update and install openvpn: 
```
yum update && yum -y update
amazon-linux-extras epel
yum install openvpn     
```
Copy the config file on the server to the client and run:
``` 
systemctl enable openvpn@server-ss-cli
systemctl server openvpn@server-ss-cli
```
