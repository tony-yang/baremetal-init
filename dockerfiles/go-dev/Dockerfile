FROM ubuntu-dev

RUN curl -O https://dl.google.com/go/go1.12.9.linux-amd64.tar.gz \
 && tar -C /usr/local -xzf go1.12.9.linux-amd64.tar.gz

RUN mkdir -p /go/src \
 && mkdir -p /go/bin \
 && mkdir -p /go/pkg

ENV GOPATH="/go"
ENV PATH="${PATH}:/usr/local/go/bin:${GOPATH}/bin"
