#!/bin/bash

sudo apt update
###
### Download latest version of docke-compose
###
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*\d')
DESTINATION=/usr/bin/docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
sudo chmod 755 $DESTINATION
docker-compose version

### 
### Create the Portainer compose
###
mkdir -p  /Portainer   
cd        /Portainer   
cat << 'EOF' >> docker-compose.yaml
---
services:
  portainer:
    image: portainer/portainer-ce:latest
    ports:
      - 9443:9443
      - 9000:9000
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    restart: unless-stopped
    
  traefik2:    
    image: traefik:latest
    restart: always
    command:
      - "--log.level=DEBUG"
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=true"
      - "--entrypoints.web.address=:80"
      - "--entrypoints.websecure.address=:443"
      - "--entrypoints.web.http.redirections.entryPoint.to=websecure"
      - "--entrypoints.web.http.redirections.entryPoint.scheme=https"
    ports:
      - 8080:80
      - 8443:443
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    container_name: traefik

  pihole:
    image: pihole/pihole:latest
    container_name: pihole
    restart: always
    ports:
      - "8090:80/tcp"
      - "8853:53/tcp"
      - "8853:53/udp"
    environment:
      TZ: 'America/Chicago'
      WEBPASSWORD: 'password'
      PIHOLE_DNS_: 1.1.1.1;9.9.9.9
      DNSSEC: 'false'
      WEBTHEME: default-dark
    
  nginx: 
    image: nginx
    ports:
      - "8011:80"
    restart: always

  busybox: 
    image: nginx
    restart: always    

  wp:
    image: wordpress:latest 
    ports:
      - 8888:80 
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_NAME: demo
      WORDPRESS_DB_USER: root
      WORDPRESS_DB_PASSWORD: demo
      WORDPRESS_TABLE_PREFIX: wp_
    depends_on:
      - db
    links:
      - db

  db:
    image: mysql
    platform: linux/x86_64
    ports:
      - 3306:3306 
    environment:
      MYSQL_DATABASE: demo
      MYSQL_ROOT_PASSWORD: demo

EOF