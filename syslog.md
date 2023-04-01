# Syslog server
In this project I user the EventLogAnalyzer from ManageEngine as my syslog server.
<br>
Link to download the syslog server:
```
https://www.manageengine.com/products/eventlog/on-prem-cloud-free-trial.html?utm_source=manageengine&utm_medium=referral&utm_campaign=index&utm_content=ela-header
```
After the download is done go to the download folder and give execution permissions to the file:  
```
cd Download/
chmod 777 <Name-of-the-Programe>
```
After you have permissions to run the file:
```
sudo ./<name-of-the-program>
```
This will make the installer pop up. 
In the installer make sure to check the box "install as a service".
<br>
After te installation is done just start the EventLogAnalyzer:
```
service eventloganalyzer start
```
# Syslog client
The only thing to do in the client is to go to the `/etc/rsyslog.conf` and add:
```
*.* @<EventLog Analyzer server IP address>:<syslog port number>
```
