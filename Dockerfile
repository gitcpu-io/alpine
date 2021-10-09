FROM alpine:edge
#default 3.14
LABEL maintainer="rubinus.chu@gmail.com"

#设置国内镜像
RUN echo 'https://mirrors.ustc.edu.cn/alpine/latest-stable/community' > /etc/apk/repositories && \
    echo 'https://mirrors.ustc.edu.cn/alpine/latest-stable/main' >> /etc/apk/repositories && \
    echo 'https://mirrors.ustc.edu.cn/alpine/edge/community' > /etc/apk/repositories && \
    echo 'https://mirrors.ustc.edu.cn/alpine/edge/main' >> /etc/apk/repositories && \
    echo 'https://mirrors.ustc.edu.cn/alpine/edge/testing' >> /etc/apk/repositories

RUN apk update

ENV TZ=Asia/Shanghai
RUN apk add --no-cache tzdata && ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apk add --upgrade --no-cache openssl openssl-dev nghttp2-dev ca-certificates

RUN apk add --upgrade --no-cache busybox-extras curl sysstat tcpdump perf procps linux-tools wrk

##安装bpf
#RUN apk add --upgrade bcc bcc-tools dev86