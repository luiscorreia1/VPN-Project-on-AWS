# Snmp client 

In order to see the computer informacion in a MibBrowser i need to install snmp and configure it.
<br>
Install snmp and its dependencies:
```
apt install snmpd snmp libsnmp-dev
```
Next to configure the snmp in `/etc/snmp/snmpd.conf`
* configure the agent to let every snmp connection:
```
agentAddress udp:161
```
* Comment  
```
#rocommunity  public default -V systemonly
#rocommunity6 public default -V systemonly
```
* Add 
```
rocommunity  public 10.0.0.13 
```
* If you want ipv6
```
agentAddress udp:161,udp6:[::1]:161
```

# MibBrowser
In this project I used MibBrowser From ManageEngine:
<br>
Link to install the MibBrowser
```
https://www.manageengine.com/products/mibbrowser-free-tool/download.html
```
After downloading the file open the terminal: 
```
cd download 
chmod 777 <name of the file>
./<name of the file>
```
And to open the MibBrowser:
```
cd ManageEngine/ManageEngine_Free_Tools/MibBrowser_Free_Tool/bin
./MibBrowser.sh 
```
