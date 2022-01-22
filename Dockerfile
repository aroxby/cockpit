FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    build-essential \
    gettext \
    gnutls-dev \
    libglib2.0-dev \
    libjson-glib-dev \
    libkrb5-dev \
    libpam-dev \
    libpcp-import1-dev \
    libpcp-pmda3-dev \
    libpolkit-agent-1-dev \
    libssh-dev \
    libsystemd-dev \
    pkg-config \
    systemd \
    wget \
    xsltproc \
    xmlto \
    xz-utils

ARG COCKPIT_VERSION=260
WORKDIR /src
RUN wget \
    "https://github.com/cockpit-project/cockpit/releases/download/${COCKPIT_VERSION}/cockpit-${COCKPIT_VERSION}.tar.xz" \
    -O cockpit-${COCKPIT_VERSION}.tar.xz
RUN tar -Jxf cockpit-*.tar.xz && rm cockpit-*.tar.xz

WORKDIR cockpit-${COCKPIT_VERSION}
RUN ./configure
RUN make && make install && cd .. && rm -rf cockpit-${COCKPIT_VERSION}
