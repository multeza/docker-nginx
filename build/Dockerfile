FROM debian:bullseye-slim

LABEL maintainer="multeza <docker@multeza.com>"

ENV NGINX_VERSION=1.21.6 \
    NJS_VERSION=0.7.2 \
    MODSEC_VERSION=3.0.6 \
    MODSEC_CONNECTOR_VERSION=1.0.2

COPY docker-entrypoint.sh /opt/nginx/

RUN mkdir -p /opt/src/modsecurity
WORKDIR /opt/src/modsecurity

RUN apt-get update && \
    apt-get install -y git autoconf automake build-essential wget libtool pkgconf \
                       libcurl4 libgeoip1 libyajl2 libcurl4-openssl-dev libgeoip-dev liblmdb-dev libpcre++-dev libxml2-dev libyajl-dev zlib1g-dev && \
    git clone --depth 1 -b v$MODSEC_VERSION --single-branch https://github.com/SpiderLabs/ModSecurity /opt/src/modsecurity && \
    git submodule init && \
    git submodule update && \
    ./build.sh && \
    ./configure && \
    make && \
    make install && \
    rm -fR /opt/src && \
    apt-get -y remove git autoconf automake build-essential wget pkgconf libcurl4-openssl-dev libgeoip-dev liblmdb-dev libpcre++-dev libxml2-dev libyajl-dev zlib1g-dev  && \
    apt-get -y autoremove && \
    apt-get clean

RUN mkdir -p /opt/src/nginx-$NGINX_VERSION
WORKDIR /opt/src/nginx-$NGINX_VERSION

RUN apt-get -y install build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev libgd-dev libxml2 libxml2-dev uuid-dev git wget && \
    apt-get clean && \    
    wget -O /tmp/nginx.tar.gz https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz && \
    tar -zxvf /tmp/nginx.tar.gz -C /opt/src/ && \
    wget -O /tmp/njs.tar.gz http://hg.nginx.org/njs/archive/$NJS_VERSION.tar.gz && \
    tar -zxvf /tmp/njs.tar.gz -C /opt/src/ && \
    git clone --depth 1 -b v$MODSEC_CONNECTOR_VERSION --single-branch https://github.com/SpiderLabs/ModSecurity-nginx.git /opt/src/modsec-connector && \
    ./configure --with-compat --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_gunzip_module --with-http_gzip_static_module --with-mail --with-mail_ssl_module --add-dynamic-module=/opt/src/modsec-connector --add-dynamic-module=/opt/src/njs-$NJS_VERSION/nginx --prefix=/opt/nginx && \
    make && \
    make install && \
    make modules && \
    mkdir -p /opt/nginx/conf/modules/ && \
    cp objs/*.so /opt/nginx/conf/modules/ && \
    rm -f /tmp/nginx.tar.gz && \
    rm -f /tmp/njs.tar.gz && \
    rm -fR /opt/src && \
    apt-get -y remove build-essential libpcre3-dev zlib1g-dev libssl-dev libgd-dev libxml2-dev uuid-dev git wget && \
    apt-get -y autoremove && \
    apt-get clean
 

EXPOSE 80 443

ENTRYPOINT ["/opt/nginx/docker-entrypoint.sh"]
