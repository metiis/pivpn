#!/usr/bin/env bash
# PiVPN: Fix iptables script
# called by pivpnDebug.sh

IPv4dev=$(ip route get 8.8.8.8 | awk '{for(i=1;i<=NF;i++)if($i~/dev/)print $(i+1)}')
IPv4addr=$(ip route get 8.8.8.8| awk '{print $7}')
iptables -t nat -F
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o ${IPv4dev} -j MASQUERADE
sudo iptables -t nat -A PREROUTING -s 10.8.0.0/24 -p tcp -j DNAT --to-destination ${IPv4addr}:9040
iptables-save > /etc/iptables/rules.v4
iptables-restore < /etc/iptables/rules.v4
