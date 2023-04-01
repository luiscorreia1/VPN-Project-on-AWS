# VPN Project on AWS

This project consists on configuring and installing a “Site to Site” vpn, “Remote Access” vpn, "EventLogAnalyzer", "FTP" and "SNMP" Servers on ubuntu and config “Site to Site”,“Remote Access”, "EventLogAnalyzer" and "SNMP" clients on amazon linux. 


![projeto](https://user-images.githubusercontent.com/114146685/229098640-73d59b25-d4aa-490c-8496-a0c42026f42b.png)
[IP configuration](vpc-pc-ips.md)

## First step
The First step of this project is to configure [NAT](nat.md) in order to have access to the internal machines.

## Second step
The Second step is to install and configure [FTP server](ftp.md), in this project the ftp was created without security to user wireshark to see the username and password.

## Third step 
The third step is to install a MibBrowser and configure [snmp](snmp.md) on the other machines 

## Fourth step 
The fourth step in to install a [syslog server](syslog.md) and add the other computer to the server.

## Final step
The final step is to install and configure the [vpn](vpn.md) on the PDL-srv and configure the client on LIS-srv.