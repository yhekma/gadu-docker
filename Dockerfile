FROM ubuntu:18.04 as builder
RUN mkdir -p /build/bin
WORKDIR /build
RUN apt update && apt install -y curl build-essential libgmp-dev
RUN curl -L http://git-annex.mysteryvortex.com/files/releases/git-annex-utils-latest.tar.bz2 -s -o - | tar xjf -
WORKDIR /build/git-annex-utils-0.04
RUN ./configure --prefix=/build && make && make install
FROM ubuntu:18.04
COPY --from=builder /build/bin/gadu /usr/local/bin
WORKDIR /mnt
ENTRYPOINT ["/usr/local/bin/gadu"]
