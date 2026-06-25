#!/bin/bash

if [ -f ./conf/nginx.conf ]; then
    exit 0
fi

mkdir -p ./conf ./log ./www

docker run --rm -v ./conf:/conf ghcr.io/restart-game-lab/openresty-tongsuo:1.31.1.1-0-noble-tongsuo sh -c \
    "cp /usr/local/openresty/nginx/conf/nginx.conf /conf/nginx.conf && \
     cp /usr/local/openresty/nginx/conf/nginx.vh.default.conf /conf/nginx.vh.default.conf"
