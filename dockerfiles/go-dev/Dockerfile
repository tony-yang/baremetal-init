FROM ubuntu-dev

RUN curl -O https://storage.googleapis.com/golang/go1.9.2.linux-amd64.tar.gz \
 && tar -C /usr/local -xzf go1.9.2.linux-amd64.tar.gz

RUN mkdir -p ${HOME}/dev/src \
 && mkdir -p ${HOME}/dev/bin \
 && mkdir -p ${HOME}/dev/pkg

ENV GOPATH="${HOME}/dev"
ENV PATH="${PATH}:/usr/local/go/bin:${GOPATH}/bin"
