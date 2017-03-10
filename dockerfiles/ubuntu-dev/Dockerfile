FROM ubuntu
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential tcl && \
  apt-get install -y ca-certificates openssl curl git vim wget python3 python3-pip ruby ruby-dev ruby-bundler zlib1g-dev liblzma-dev && \
  rm -rf /var/lib/apt/lists/*

ADD config/vimrc /root/.vimrc
ADD config/gitconfig /root/.gitconfig

ENV HOME /root

WORKDIR /root

CMD ["bash"]
