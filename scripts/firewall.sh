#!/bin/bash

## SCRIPT de IPTABLES
## DROP default Police

echo "-----------Apply rules Firewall--------"

## FLUSH rules
iptables -F
iptables -X
iptables -Z


## Drop default Policy 
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
#iptables -P INPUT ACCEPT
#iptables -P OUTPUT ACCEPT
#iptables -P FORWARD ACCEPT


# Block ip
iptables -A INPUT -s 69.21.0.0/16 -p tcp --dport 1:10000 -j DROP


# NTP
iptables -A INPUT -p udp --sport 123 -j ACCEPT
iptables -A OUTPUT -p udp --dport 123 -j ACCEPT

# DNS
iptables -A INPUT -p udp --sport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
#iptables -A INPUT -p tcp --sport 53 -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT


# Localhost all access 
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# MySQL Access from local network
iptables -A INPUT -s 172.18.21.0/24 -p tcp --dport 3306 -j ACCEPT
iptables -A OUTPUT -d 172.18.21.0/24 -p tcp --sport 3306 -j ACCEPT


# SSH on port 2233
iptables -A INPUT -s 0.0.0.0/0 -p tcp --dport 2233 -j ACCEPT
iptables -A OUTPUT -d 0.0.0.0/0 -p tcp --sport 2233 -j ACCEPT
# Client SSH
iptables -A INPUT -p tcp --sport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT

# HTTP and HTTPS Access
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 80 -j ACCEPT
iptables -A INPUT -p tcp --sport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 443 -j ACCEPT
iptables -A INPUT -p tcp --sport 443 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT


# SAMBA from local network
#iptables -A INPUT -s 192.168.1.0/24 -p tcp --sport 445 -j ACCEPT
#iptables -A OUTPUT -d 192.168.1.0/24 -p tcp --dport 445 -j ACCEPT
#iptables -A INPUT -s 192.168.1.0/24 -p tcp --dport 445 -j ACCEPT
#iptables -A OUTPUT -d 192.168.1.0/24 -p tcp --sport 445 -j ACCEPT

# SAMBA from local network
#iptables -A INPUT -s 192.168.1.0/24 -p udp --sport 137 -j ACCEPT
#iptables -A INPUT -s 192.168.1.0/24 -p tcp --sport 137 -j ACCEPT
#iptables -A OUTPUT -d 192.168.1.0/24 -p udp --dport 137 -j ACCEPT
#iptables -A OUTPUT -d 192.168.1.0/24 -p tcp --dport 137 -j ACCEPT

# Close open ports
iptables -A INPUT -p tcp --dport 1:4024 -j DROP
iptables -A INPUT -p udp --dport 1:4024 -j DROP
iptables -A INPUT -p tcp --dport 3306 -j DROP
iptables -A INPUT -p tcp --dport 2233 -j DROP
iptables -A INPUT -p tcp --dport 10000 -j DROP
iptables -A INPUT -p udp --dport 10000 -j DROP

echo "..OK "
