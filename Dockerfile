FROM alpine:edge
#default 3.14
LABEL maintainer="rubinus.chu@gmail.com"

#设置国内镜像
RUN echo 'https://mirrors.ustc.edu.cn/alpine/latest-stable/community' > /etc/apk/repositories
RUN echo 'https://mirrors.ustc.edu.cn/alpine/latest-stable/main' >> /etc/apk/repositories
RUN echo 'https://mirrors.ustc.edu.cn/alpine/edge/community' > /etc/apk/repositories
RUN echo 'https://mirrors.ustc.edu.cn/alpine/edge/main' >> /etc/apk/repositories
RUN echo 'https://mirrors.ustc.edu.cn/alpine/edge/testing' >> /etc/apk/repositories
RUN apk update

#访问外部的https
RUN apk add --no-cache ca-certificates

#访问外部的https及安装curl
ENV CURL_VERSION 7.67.0

RUN apk add --update --no-cache openssl openssl-dev nghttp2-dev ca-certificates
RUN apk add --update --no-cache --virtual curldeps g++ make perl && \
wget https://curl.haxx.se/download/curl-$CURL_VERSION.tar.bz2 && \
tar xjvf curl-$CURL_VERSION.tar.bz2 && \
rm curl-$CURL_VERSION.tar.bz2 && \
cd curl-$CURL_VERSION && \
./configure \
    --with-nghttp2=/usr \
    --prefix=/usr \
    --with-ssl \
    --enable-ipv6 \
    --enable-unix-sockets \
    --without-libidn \
    --disable-static \
    --disable-ldap \
    --with-pic && \
make && \
make install && \
cd / && \
rm -r curl-$CURL_VERSION && \
rm -r /var/cache/apk && \
rm -r /usr/share/man && \
apk del curldeps


ENV TZ=Asia/Shanghai
RUN apk add --no-cache tzdata && ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apk add --upgrade sysstat

RUN apk add --upgrade tcpdump

RUN apk add --upgrade perf procps