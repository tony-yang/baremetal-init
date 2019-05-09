FROM ubuntu-dev

RUN curl -O https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz \
 && tar -C /usr/local -xzf go1.12.5.linux-amd64.tar.gz

RUN mkdir -p ${HOME}/dev/src \
 && mkdir -p ${HOME}/dev/bin \
 && mkdir -p ${HOME}/dev/pkg

ENV GOPATH="${HOME}/dev"
ENV PATH="${PATH}:/usr/local/go/bin:${GOPATH}/bin"
