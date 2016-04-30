FROM phusion/baseimage:0.9.18

MAINTAINER Andy Grant <andy.a.grant@gmail.com>

ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN \
  apt-get install -y \
  build-essential \
  git \
  tcl

RUN rm -rf /var/lib/apt/lists/*

ENV SHA1 0192ba7e1cda157024229962b7bee1c6e86d771b

RUN \
  cd /tmp && \
  ssh-keyscan github.com >> ~/.ssh/known_hosts && \
  git clone https://github.com/antirez/disque.git && \
  cd disque && \
  git reset --hard $SHA1 && \
  make && \
  make install && \
  mkdir -p /etc/disque && \
  rm -rf /tmp/disque && \
  groupadd disque && \
  useradd -g disque disque

VOLUME ["/data"]

RUN mkdir /etc/service/disque
ADD disque.sh /etc/service/disque/run
ADD disque.conf /etc/disque/disque.conf

EXPOSE 7711

CMD ["/sbin/my_init", "--quiet"]
