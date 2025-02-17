#!/bin/bash

# 创建程序目录
# mkdir -p /usr/bin/v2ray

# 安装V2Ray
# curl https://install.direct/go.sh | bash

# 删除额外的功能
# rm -rf /usr/bin/v2ray/geosite.dat /usr/bin/v2ray/geoip.dat

# 设置V2Ray新的配置
cat <<-EOF > /etc/v2ray/config.json
{
    "policy":null,
    "log":{
        "access":"",
        "error":"",
        "loglevel":"warning"
    },
    "inbounds":[
        {
            "tag":null,
            "port":${PORT},
            "listen":null,
            "protocol":"vmess",
            "sniffing":null,
            "settings":{
                "auth":null,
                "udp":false,
                "ip":null,
                "address":null,
                "clients":[
                    {
                        "id":"${UUID}",
                        "alterId":64,
                        "email":"t@t.tt",
                        "security":null
                    }
                ]
            },
            "streamSettings":{
                "network":"ws",
                "security":"tls",
                "tlsSettings":{
                    "allowInsecure":true,
                    "serverName":"${APPNAME}.herokuapp.com"
                },
                "tcpSettings":null,
                "kcpSettings":null,
                "wsSettings":{
                    "connectionReuse":true,
                    "path":"${PATH}",
                    "headers":{
                        "Host":"${APPNAME}.herokuapp.com"
                    }
                },
                "httpSettings":null,
                "quicSettings":null
            }
        }
    ],
    "outbounds":null,
    "stats":null,
    "api":null,
    "dns":null,
    "routing":{
        "domainStrategy":"IPIfNonMatch",
        "rules":[

        ]
    }
}
EOF
/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json
