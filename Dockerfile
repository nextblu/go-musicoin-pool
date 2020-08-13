FROM alpine:3.12.0

ENV GOPATH /home/go

RUN apk --update add -ut build-deps \
    linux-headers \
    go \
    git \
    g++ \
    make

RUN git config --global http.https://gopkg.in.followRedirects true

WORKDIR /opt

RUN git clone https://github.com/Musicoin/go-musicoin.git

WORKDIR /opt/go-musicoin

RUN make gmc

RUN chmod a+x /opt/go-musicoin/build/bin/gmc
RUN ln -s /opt/go-musicoin/build/bin/gmc /usr/bin/geth
RUN ln -s /opt/go-musicoin/build/bin/gmc /usr/bin/gmc

COPY run.sh /run.sh

WORKDIR /

CMD ["/run.sh"]


EXPOSE 8545
