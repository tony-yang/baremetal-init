FROM ubuntu

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update && apt-get install -y \
    build-essential \
    ca-certificates \
    curl \
    git \
    liblzma-dev \
    libmysqlclient-dev \
    mysql-server \
    nodejs \
    openssl \
    python3 \
    python3-pip \
    ruby \
    ruby-dev \
    ruby-bundler \
    tcl \
    vim \
    wget \
    zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*

COPY config/vimrc /root/.vimrc
COPY config/gitconfig /root/.gitconfig

ENV HOME /root

WORKDIR /root

CMD ["bash"]
