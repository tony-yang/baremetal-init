FROM ubuntu:latest
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y wget build-essential tcl8.5 && \
  cd && \
  wget http://download.redis.io/releases/redis-3.2.6.tar.gz && \
  tar xzf redis-3.2.6.tar.gz && \
  cd redis-3.2.6 && make && make install && \
  ./redis-3.2.6/utils/install_server.sh && \
  rm -rf /var/lib/apt/lists/*

COPY 6379.conf /etc/redis/

EXPOSE 6379

ENTRYPOINT ["redis-server", "/etc/redis/6379.conf"]
