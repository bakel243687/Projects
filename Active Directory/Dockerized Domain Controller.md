# Dockerized Domain Controller

I actually deceided to make a docker domain controller similar to the one on my raspberry pi

I've been on this docker for a week now and I couldn't tell much on the issue, but bless community support.

## Setup
Created my docker directory as below:


In my dockerfiler,
```
  GNU nano 8.7                       Dockerfile                                 
FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    samba \
    samba-dsdb-modules \
    samba-vfs-modules \
    winbind \
    krb5-user \
    dnsutils \
    supervisor \
    && apt clean

RUN mkdir -p /var/lib/samba /etc/samba

EXPOSE 53 88 135 139 389 445 464 636 3268 3269

CMD ["tail", "-f", "/dev/null"]
```

Compose,yml file
```                                
version: "3.9"

services:
  samba-ad:
    build: .
    container_name: samba-ad-dc
    hostname: dc1
    domainname: lab.local
    cap_add:
      - SYS_ADMIN
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "88:88/tcp"
      - "88:88/udp"
      - "135:135/tcp"
      - "139:139/tcp"
      - "389:389/tcp"
      - "389:389/udp"
      - "445:445/tcp"
      - "464:464/tcp"
      - "464:464/udp"
      - "636:636/tcp"
      - "3268:3268/tcp"
      - "3269:3269/tcp"
    volumes:
      - ./data/lib:/var/lib/samba
      - ./data/etc:/etc/samba

    restart: unless-stopped
    networks:
      ad-network:
        ipv4_address: 192.168.100.10

networks:
  ad-network:
    driver: bridge
    ipam:
      config:
        - subnet: 192.168.100.0/24
```

with the above docker files set in my directory, Using the below commands, the docker was up and running

docker-compose 

https://github.com/instantlinux/docker-tools/issues/84

## TroubleShooting

I was not able to build the docker due to commands used in the docker compose file
I had issues with setting up the samba network like I did in the raspberry pi setup
I has an issue with downloading optional features for My Windows VM
Faced with the problem of connecting my docker to the virtual machine as they are both on different networks
