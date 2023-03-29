install mib browser form manageengine:
```
https://www.manageengine.com/products/mibbrowser-free-tool/download.html
```
after downloadign the file open the terminal and do the next steps 
```
cd download 
chmod 777 <name of the file>
./<name of the file>
```

and to open the browser 

```
cd ManageEngine/ManageEngine_Free_Tools/MibBrowser_Free_Tool/bin
./MibBrowser.sh 
```


to add a clint 

```
apt install snmpd snmp libsnmp-dev
nano /etc/snmp/snmpd.conf
agentAddress udp:161

commentar 
#rocommunity  public default -V systemonly
#rocommunity6 public default -V systemonly
add 
rocommunity  public 10.0.0.13 

If you want ipv6
agentAddress udp:161,udp6:[::1]:161
```
