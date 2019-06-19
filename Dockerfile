FROM ubuntu:trusty
MAINTAINER dev@twindb.com

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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
        libgcrypt11-dev \
        libev-dev \
        vim-common

# For gcc version 7
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
RUN apt update || apt update
RUN apt -y install g++-7
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/g++ g++ /usr/bin/g++-7
RUN update-alternatives --config gcc

RUN apt-get -y install python-pip python-dev
RUN pip install awscli

COPY gpg/409B6B1796C275462A1703113804BB82D39DC0E3.txt /tmp/409B6B1796C275462A1703113804BB82D39DC0E3.txt
COPY gpg/7D2BAF1CF37B13E2069D6956105BD0E739499BDB.txt /tmp/7D2BAF1CF37B13E2069D6956105BD0E739499BDB.txt
RUN gpg2 --import /tmp/7D2BAF1CF37B13E2069D6956105BD0E739499BDB.txt
RUN gpg2 --import /tmp/409B6B1796C275462A1703113804BB82D39DC0E3.txt

RUN curl -sSL https://get.rvm.io | bash -s stable

RUN bash -lc "rvm requirements; \
        rvm install 2.6.1 ; \
        gem install bundler; \
        rm -rf /usr/local/rvm/src/ruby-* ; \
        "

COPY Gemfile.lock Gemfile /tmp/
RUN bash -lc "cd /tmp/; bundle install --binstubs"

CMD /bin/bash -l
