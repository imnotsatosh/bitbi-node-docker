# Smallest base image, latests stable image
# Alpine would be nice, but it's linked again musl and breaks the bitbi download binary
#FROM alpine:latest

FROM ubuntu:latest AS builder
ARG TARGETARCH

FROM builder AS builder_amd64
ENV ARCH=x86_64
FROM builder AS builder_arm64
ENV ARCH=aarch64
FROM builder AS builder_riscv64
ENV ARCH=riscv64

FROM builder_${TARGETARCH} AS build

# Testing: gosu
#RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories \
#    && apk add --update --no-cache gnupg gosu gcompat libgcc
RUN apt update \
    && apt install -y --no-install-recommends \
    ca-certificates \
    gnupg \
    libatomic1 \
    wget \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG VERSION=26.101.0
ARG BITCOIN_CORE_SIGNATURE=71A3B16735405025D447E8F274810B012346C9A6

# Don't use base image's bitbi package for a few reasons:
# 1. Would need to use ppa/latest repo for the latest release.
# 2. Some package generates /etc/bitbi.conf on install and that's dangerous to bake in with Docker Hub.
# 3. Verifying pkg signature from main website should inspire confidence and reduce chance of surprises.
# Instead fetch, verify, and extract to Docker image
RUN cd /tmp \
    && wget https://bitbi.org/download/bitbi/${VERSION}/bitbi-${VERSION}-${ARCH}-linux-gnu.tar.gz \
    && tar -xzvf bitbi-${VERSION}-${ARCH}-linux-gnu.tar.gz -C /opt \
    && ln -sv bitbi-${VERSION} /opt/bitbi \
    && rm -v /opt/bitbi/bin/bitbi-qt

FROM ubuntu:latest
LABEL maintainer="imnotsatoshi <imnotsatoshi@proton.me>"

ENTRYPOINT ["docker-entrypoint.sh"]
ENV HOME /bitbi
EXPOSE 9801 9800 9802
VOLUME ["/bitbi/.bitbi"]
WORKDIR /bitbi

ARG GROUP_ID=1000
ARG USER_ID=1000
RUN groupadd -g ${GROUP_ID} bitbi \
    && useradd -u ${USER_ID} -g bitbi -d /bitbi bitbi

COPY --from=build /opt/ /opt/

RUN apt update \
    && apt install -y --no-install-recommends gosu libatomic1 \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && ln -sv /opt/bitbi/bin/* /usr/local/bin

COPY ./bin ./docker-entrypoint.sh /usr/local/bin/

CMD ["btb_oneshot"]
