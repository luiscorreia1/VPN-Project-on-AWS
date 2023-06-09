# NAT
Because I have internal computer and want to make a site to site vpn i need to config the NAT with port overload to have access to the internal computer and the site to site client as well.  
## Nat on ubuntu
First update the machine and install the application needed to do nat:
```
apt update && apt -y upgrade
apt install netfilter-persistent iptables-persistent net-tools
```
Next is to uncomment the `net.ipv4.ip_forward = 1` in the file `/etc/sysctl.conf` and make sure it's 1 or otherwise it's not going to forward ipv4:
```
nano /etc/sysctl.conf
``` 
Check if the configuration of the `sysctl.conf` was saved by:
```
sysctl -p
```
Output:
```
net.ipv4.ip_forward = 1
```
Next is to configure the Iptables:
<br>
Turn on lan routing:
```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```
Make port forwarding:
```
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 3389 -j DNAT --to-destination 172.21.1.101
```
To apply the changes:
```
netfilter-persistent save
netfilter-persistent reload
```


## Nat on redhat 

First update the machine and install the application needed to do nat:
```
yum update && yum -y upgrade
yum install -y iptables-services
```

Next is to uncomment ther `net.ipv4.ip_forward = 1` in the file `/etc/sysctl.conf` and make sure it's 1 or otherwise it's not going to forward ipv4:
```
nano /etc/sysctl.conf
``` 
Check if the configuration of the `sysctl.conf` was saved by:
```
sysctl -p
```
Output:
```
net.ipv4.ip_forward = 1
```
Next is to configure the Iptables:
<br>
Turn on lan routing:
```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```
Make port forwarding:
```
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 3389 -j DNAT --to-destination 192.168.0.81
```
To apply the changes:
```  
iptables -F
service iptables save
```

# Client
On the client i need to add the next lines to the netplan in other to have internet on the client
```
routes:
  - to: 0.0.0.0/0
    via:172.16.1.100
    on-link: true
```
You need to be very carefully because if you hava a wrong ip or a space more or less you could lose access to the computer.
<br>
After adding the config to the file save the netplan:
```
netplan try
```
I used netplan try instead of using netplan apply to check if the configuration is correct 