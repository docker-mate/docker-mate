#!/usr/bin/env bash
bash .docker-mate/utils/message.sh info "Starting reverse proxy..."
docker rm docker-mate-http-proxy
docker run -d --restart=always \
    -v /var/run/docker.sock:/tmp/docker.sock:ro \
    -v ~/.dinghy/certs:/etc/nginx/certs \
    -p 80:80 -p 443:443 \
    -p 19322:19322/udp \
    -e DNS_IP=127.0.0.1 \
    -e CONTAINER_NAME=docker-mate-http-proxy \
    --name docker-mate-http-proxy \
    codekitchen/dinghy-http-proxy
