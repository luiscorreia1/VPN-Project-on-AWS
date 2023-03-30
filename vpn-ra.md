install the vpn and easy-rsa:

```
apt install openvpn easy-rsa
```
create the certs you are going to need:
```
easy-rsa:

cd /etc
cp -R /usr/share/easy-rsa/ .
cd easy-rsa/
./easyrsa init-pki
./easyrsa build-ca nopass
./easyrsa build-server-full vpnsrv.enta.pt nopass
./easyrsa build-clint-full vpncli.enta.pt nopass
./easyrsa --subject-alt-name="DNS:www.enta.pt" sign-req server www.enta.pt

openvpn:

cd /etc/openvpn/   
openssl dhparam -out dh2048.pem 2048
openvpn --genkey --secret ta.key

```    
copy the easy-rsa certs to the vpn folder: 
```
cp /etc/easy-rsa/pki/issued/vpncli.enta.pt.crt /etc/openvpn/
cp /etc/easy-rsa/pki/private/vpncli.enta.pt.key /etc/openvpn/
cp /etc/easy-rsa/pki/issued/vpnsrv.enta.pt.crt /etc/openvpn/
cp /etc/easy-rsa/pki/private/vpnsrv.enta.pt.key /etc/openvpn/
cp /etc/easy-rsa/pki/ca.crt /etc/openvpn/
cp /etc/easy-rsa/pki/private/ca.key /etc/openvpn/
```
copy server and client sample:
```
cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf /etc/openvpn/  
cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf /etc/openvpn/  
```
make a copy of the server sample:
```
cp server.conf server-ss.conf      #for site to site 
cp server.conf server-ss-cli.conf  #for the site to site cli 
cp server.conf server-ra.conf      #for remote acess 
```   
   
to activate the vpn:   
```
systemctl enable openvpn@server-ra
systemctl start openvpn@server-ra
systemctl enable openvpn@server-ss
systemctl server openvpn@server-ss
```
check if the port of the vpn are open 
```
netstat -nulp
```   
edit the client config that is use to connect to the server:
```
nano /etc/openvpn/client.conf 
```     
     
     


  
  
  
