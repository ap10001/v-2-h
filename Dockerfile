FROM alpine:latest

# 安装临时组件
RUN echo $(apk add --no-cache --virtual .build-deps ca-certificates curl bash)

# 创建程序目录
RUN echo $(mkdir -p /usr/bin/v2ray)

# 安装V2Ray
RUN echo $(curl https://install.direct/go.sh | bash)

# 删除额外的功能
# RUN echo $(rm -rf /usr/bin/v2ray/geosite.dat /usr/bin/v2ray/geoip.dat)

# 复制configure.sh文件
ADD configure.sh /configure.sh

# 更改文件权限为可执行
RUN echo $(chmod +x /configure.sh)

# 执行configure.sh文件
# CMD echo $(/configure.sh)

RUN echo $(cat > /etc/v2ray/config.json <<'EOF' \
{ \
    "policy":null, \
    "log":{ \
        "access":"", \
        "error":"", \
        "loglevel":"warning" \
    }, \
    "inbounds":[ \
        { \
            "tag":null, \
            "port":${PORT}, \
            "listen":null, \
            "protocol":"vmess", \
            "sniffing":null, \
            "settings":{ \
                "auth":null, \
                "udp":false, \
                "ip":null, \
                "address":null, \
                "clients":[ \
                    { \
                        "id":"${UUID}", \
                        "alterId":64, \
                        "email":"t@t.tt", \
                        "security":null \
                    } \
                ] \
            }, \
            "streamSettings":{ \
                "network":"ws", \
                "security":"tls", \
                "tlsSettings":{ \
                    "allowInsecure":true, \
                    "serverName":"${APPNAME}.herokuapp.com" \
                }, \
                "tcpSettings":null, \
                "kcpSettings":null, \
                "wsSettings":{ \
                    "connectionReuse":true, \
                    "path":"${PATH}", \
                    "headers":{ \
                        "Host":"${APPNAME}.herokuapp.com" \
                    } \
                }, \
                "httpSettings":null, \
                "quicSettings":null \
            } \
        } \
    ], \
    "outbounds":null, \
    "stats":null, \
    "api":null, \
    "dns":null, \
    "routing":{ \
        "domainStrategy":"IPIfNonMatch", \
        "rules":[ \
        ] \
    } \
} \
EOF \
)

