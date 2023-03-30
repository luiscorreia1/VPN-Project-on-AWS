#Nat on ubuntu 
```
apt update && apt -y upgrade
apt install netfilter-persistent iptables-persistent net-tools
```
nano /etc/sysctl.conf
```
net.ipv4.ip_forward = 1
``` 

you can check if the ipv4 forwarding is working by using:
```
sysctl -p
```

Iptables rules:
```
turn on lan routing:

  iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
port forwarding:

  iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 3389 -j DNAT --to-destination 10.0.1.10

after to apply the changes:

  netfilter-persistent save
  netfilter-persistent reload
```


#Nat on red hat 

Update and install Iptables for nat:
```
yum update && yum -y upgrade
yum install -y iptables-services
```

nano /etc/sysctl.conf
```
uncomment
net.ipv4.ip_forward = 1
```
you can check if the ipv4 forwarding is working by using:
```
sysctl -p
```
Iptables rules:
```
turn on lan routing:

  iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

port forwarding:
  
  iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 3389 -j DNAT --to-destination 10.0.1.10

after to apply the changes:
  
  iptables -F
  service iptables save
```
