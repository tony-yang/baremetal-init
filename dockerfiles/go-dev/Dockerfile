FROM ubuntu-dev

RUN curl -O https://storage.googleapis.com/golang/go1.9.2.linux-amd64.tar.gz \
 && tar -C /usr/local -xzf go1.9.2.linux-amd64.tar.gz

ENV PATH="${PATH}:/usr/local/go/bin"
ENV GOPATH="${HOME}"
