#!/usr/bin/env bash

apt-get update
apt-get upgrade
apt-get install openvpn easy-rsa

cd /home/ubuntu/Download/
wget https://www.manageengine.com/products/eventlog/91517554/ManageEngine_EventLogAnalyzer_64bit.bin
wget https://www.manageengine.com/products/mibbrowser-free-tool/9229779/ManageEngine_MibBrowser_FreeTool_64bit.bin
chmod 777 *

cd /etc
cp -R /usr/share/easy-rsa/ .
cd easy-rsa/
./easyrsa init-pki
./easyrsa build-ca nopass
./easyrsa build-server-full vpnsrv.enta.pt nopass
./easyrsa build-clint-full vpncli.enta.pt nopass
./easyrsa --subject-alt-name="DNS:www.enta.pt" sign-req server www.enta.pt

cd /etc/openvpn/
openssl dhparam -out dh2048.pem 2048
openvpn --genkey --secret ta.key

cp /etc/easy-rsa/pki/issued/vpncli.enta.pt.crt /etc/openvpn/
cp /etc/easy-rsa/pki/private/vpncli.enta.pt.key /etc/openvpn/
cp /etc/easy-rsa/pki/issued/vpnsrv.enta.pt.crt /etc/openvpn/
cp /etc/easy-rsa/pki/private/vpnsrv.enta.pt.key /etc/openvpn/
cp /etc/easy-rsa/pki/ca.crt /etc/openvpn/
cp /etc/easy-rsa/pki/private/ca.key /etc/openvpn/
cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf /etc/openvpn/
cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf /etc/openvpn/
cp server.conf server-ss.conf
cp server.conf server-ss-cli.conf
cp server.conf server-ra.conf