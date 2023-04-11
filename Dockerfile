FROM alpine:latest

# 执行更新
RUN apk update && apk add --no-cache openssl squid

# 安装trojan-go
RUN wget https://github.com/p4gefau1t/trojan-go/releases/download/v0.9.1/trojan-go-linux-amd64.zip -O /tmp/trojan-go.zip \
    && unzip /tmp/trojan-go.zip -d /usr/bin/ \
    && rm -f /tmp/trojan-go.zip \
    && chmod +x /usr/bin/trojan-go

# 复制配置文件
COPY trojan-go-server.json /etc/

# 添加启动脚本
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# 添加密钥
COPY www.pem /usr/local/share/ca-certificates/trojan-go.pem
COPY www.key /usr/local/share/ca-certificates/trojan-go.key
RUN chmod 644 /usr/local/share/ca-certificates/trojan-go.*



# 暴露端口
EXPOSE 443/tcp 80/tcp

# 容器启动时执行entrypoint.sh脚本
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

