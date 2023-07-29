FROM ubuntu:focal
MAINTAINER dev@twindb.com

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
        git \
        curl \
        build-essential \
        libssl-dev \
        libreadline-dev \
        libxslt1-dev \
        libxml2-dev \
        libcurl4-gnutls-dev \
        zlib1g-dev \
        libexpat1-dev \
        libicu-dev \
        gnupg2 \
        cmake \
        flex \
        bison \
        automake \
        autoconf \
        libtool \
        libaio-dev \
        mysql-client \
        libncurses-dev \
        libgcrypt20-dev \
        libev-dev \
        vim-common \
        unzip \
        ruby \
        ruby-dev \
        ruby-bundler \
        pkgconf; \
    apt-get clean

RUN gem install omnibus

CMD /bin/bash -l
