# VPN Project on AWS

This project consists on configuring and installing a “Site to Site” vpn, “Remote Access” vpn, "EventLogAnalyzer", "FTP" and "SNMP" Servers on ubuntu and config “Site to Site”,“Remote Access”, "EventLogAnalyzer" and "SNMP" clients on amazon linux. 


![projeto](https://user-images.githubusercontent.com/114146685/229098640-73d59b25-d4aa-490c-8496-a0c42026f42b.png)
[IP configuration](vpc-pc-ips.md)

## First step
The First step of this project is to configure [NAT](NAT.md) in order to have access to the internal machines.

## second step
The Second step is to install and configure [ftp server](FTP.md), in this project the ftp was created without security to user wireshark to see the username and password.
