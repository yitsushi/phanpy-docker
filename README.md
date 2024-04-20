# Unofficial Phanpy Docker Image

## Docker run

```bash
docker run ghcr.io/yitsushi/phanpy-docker:latest
```

## Docker Compose

```yaml
---
version: "3.9"
services:
  phanpy:
    image: ghcr.io/yitsushi/phanpy-docker:latest
    container_name: phanpy
    ports:
      - 8080:80
```

## An example on Docker Stack

That's how I deployed on my swarm cluster:

```yaml
---
version: '3.9'

services:
  stable:
    image: ghcr.io/yitsushi/phanpy-docker:2024.04.04.65d51b0
    networks:
      - traefik-public
    ports:
      - 80
    deploy:
      labels:
        - "homepage.group=Social"
        - "homepage.icon=/icons/phanpy.png"
        - "homepage.name=Phanpy"
        - "homepage.href=https://phanpy.efertone.me/"
        - "homepage.description=Alternative Mastodon Web Client"

        - "traefik.enable=true"
        - "traefik.http.routers.phanpy-efertone-me.rule=Host(`phanpy.efertone.me`)"
        - "traefik.http.services.phanpy-efertone-me.loadbalancer.server.port=80"
        - "traefik.http.routers.phanpy-efertone-me.tls=true"
        - "traefik.http.routers.phanpy-efertone-me.tls.certresolver=cloudflare"
        - "traefik.http.routers.phanpy-efertone-me.entryPoints=http,https"
        - "traefik.docker.network=traefik-public"

networks:
  traefik-public:
    external: true
```
