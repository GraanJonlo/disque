FROM phusion/baseimage:0.9.18

MAINTAINER Andy Grant <andy.a.grant@gmail.com>

RUN \
  apt-get update && apt-get upgrade -y && apt-get install -y \
  build-essential \
  git \
  tcl

ENV SHA1 3573254149706a5dfafc142bce12c7976792c5a2

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

