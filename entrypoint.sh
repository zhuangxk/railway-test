#!/bin/sh

# 启动squid服务
/usr/sbin/squid -N &

# 启动trojan-go服务
/usr/bin/trojan-go -config /etc/trojan-go-server.json
