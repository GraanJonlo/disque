FROM phusion/baseimage:0.9.18

MAINTAINER Andy Grant <andy.a.grant@gmail.com>

RUN \
  apt-get update && apt-get upgrade -y && apt-get install -y \
  build-essential \
  git \
  tcl

RUN rm -rf /var/lib/apt/lists/*

ENV SHA1 fe8210eaa9c27946a915a0e0759f400888513d4b

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
