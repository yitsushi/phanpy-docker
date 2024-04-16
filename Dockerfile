from alpine:3.19 as builder

ARG VERSION

run apk add --update curl
run curl -sLO "https://github.com/cheeaun/phanpy/releases/download/${VERSION}/phanpy-dist.tar.gz" \
  && mkdir /phanpy \
  && tar zxf phanpy-dist.tar.gz -C /phanpy

from nginx:1.25.4-alpine

label maintainer="Victoria Nadasdi <efertone@pm.me>"
label org.opencontainers.image.source=https://github.com/yitsushi/phanpy-docker
label org.opencontainers.image.description="Unofficial Docker Image for Phanpy"
label org.opencontainers.image.licenses=MIT

copy --from=builder /phanpy /usr/share/nginx/html
