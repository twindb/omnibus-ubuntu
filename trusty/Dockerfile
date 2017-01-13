FROM ubuntu:trusty
MAINTAINER Ovais Tariq @ovaistariq

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    libssl-dev \
    libreadline-dev \
    libxslt1-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libexpat1-dev \
    libicu-dev \
    cmake

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable

RUN sed -i "s/libgmp-dev//g" /usr/local/rvm/scripts/functions/requirements/debian

RUN /bin/bash -l -c "rvm requirements && rvm install 2.2.2 && gem install bundler --no-ri --no-rdoc" && \
    rm -rf /usr/local/rvm/src/ruby-2.2.2

RUN git config --global user.email "packager@twindb.com" && \
    git config --global user.name "TwinDB Packager (TwinDB packager key)" && \
    git clone https://github.com/twindb/backup.git /twindb-backup

RUN cd /twindb-backup/omnibus && \
    /bin/bash -l -c "bundle install --binstubs"

ENTRYPOINT /bin/bash -l /twindb-backup/omnibus/omnibus_build.sh
