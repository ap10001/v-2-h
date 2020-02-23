FROM heroku/heroku:latest

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
# RUN echo $'' >> /etc/v2ray/config.json

# 复制config.json文件
ADD server_config.json /etc/v2ray/config.json

# 显示config.json文件
RUN echo $(cat /etc/v2ray/config.json)

# 执行
CMD echo $(/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json)


