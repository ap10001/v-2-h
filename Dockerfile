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
# ADD configure.sh /configure.sh

# 更改文件权限为可执行
# RUN echo $(chmod +x /configure.sh)

# 执行configure.sh文件
# CMD echo $(/configure.sh)

# 执行
RUN echo $'{\n\
    "policy":null,\n\
    "log":{\n\
        "access":"",\n\
        "error":"",\n\
        "loglevel":"warning"\n\
    },\n\
    "inbounds":[\n\
        {\n\
            "tag":null,\n\
            "port":${PORT},\n\
            "listen":null,\n\
            "protocol":"vmess",\n\
            "sniffing":null,\n\
            "settings":{\n\
                "auth":null,\n\
                "udp":false,\n\
                "ip":null,\n\
                "address":null,\n\
                "clients":[\n\
                    {\n\
                        "id":"${UUID}",\n\
                        "alterId":64,\n\
                        "email":"t@t.tt",\n\
                        "security":null\n\
                    }\n\
                ]\n\
            },\n\
            "streamSettings":{\n\
                "network":"ws",\n\
                "security":"tls",\n\
                "tlsSettings":{\n\
                    "allowInsecure":true,\n\
                    "serverName":"${APPNAME}.herokuapp.com"\n\
                },\n\
                "tcpSettings":null,\n\
                "kcpSettings":null,\n\
                "wsSettings":{\n\
                    "connectionReuse":true,\n\
                    "path":"${PATH}",\n\
                    "headers":{\n\
                        "Host":"${APPNAME}.herokuapp.com"\n\
                    }\n\
                },\n\
                "httpSettings":null,\n\
                "quicSettings":null\n\
            }\n\
        }\n\
    ],\n\
    "outbounds":null,\n\
    "stats":null,\n\
    "api":null,\n\
    "dns":null,\n\
    "routing":{\n\
        "domainStrategy":"IPIfNonMatch",\n\
        "rules":[\n\
        ]\n\
    }\n\
}\n'\
>> /etc/v2ray/config.json

# 显示config.json文件
RUN echo $(cat /etc/v2ray/config.json)

# 执行configure.sh文件
# RUN echo $(/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json)

