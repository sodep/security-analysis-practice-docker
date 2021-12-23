#############################################################################
# Dockerfile to build an image with Git, php-cli and composer
# Based on yesops/ubuntu:latest
#############################################################################

## Set the base image to Ubuntu
FROM ubuntu:20.04

MAINTAINER Sodep <info@sodep.com.py>

# Set the locale
RUN apt-get clean && apt-get update
RUN apt-get -y install  wget locales locales-all

## Update locale
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

## Install basic things
RUN apt-get install -y --no-install-recommends \

	gpg-agent \
	libpng-dev \
	apt-transport-https \
	software-properties-common \
	openssh-client \
	curl \
	ca-certificates \
	wget \
	git \
	gcc \
	make \
	mcrypt \
	libxrender1 \
	libxtst6


## Add php repository
RUN add-apt-repository ppa:ondrej/php -y

## Add git repository
RUN add-apt-repository ppa:git-core/ppa -y

## Add yarn repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

## Installs PHP
RUN apt-get update && \
    apt-get -y install \
        php-cli \
        php-curl \
        php-mbstring \
        php-gd \
        php-mysql \
        php-json \
        php-ldap \
        php-mime-type \
		php-pgsql \
        php-tidy \
        php-intl \
        php-xmlrpc \
        php-soap \
        php-uploadprogress \
        php-zip && \
    apt-get -y autoremove && \
    apt-get -y install --no-install-recommends imagemagick && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


## Upgrades
RUN apt-get dist-upgrade -y

## Install node and npm
RUN apt-get update && apt-get install -y nodejs npm

## Install Snyk cli
RUN npm install snyk@latest -g

## Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

## Add composer bin to PATH
ENV PATH "$PATH:$HOME/.composer/vendor/bin"


## Install composer plugins
RUN /usr/local/bin/composer global require "laravel/envoy:^1.4"

RUN mkdir -p "/usr/course"
WORKDIR /usr/course/
RUN git clone https://github.com/sonatype-nexus-community/bach.git
WORKDIR /usr/course/bach
RUN composer install


RUN echo "Adding repositories"
RUN mkdir -p "/usr/course/repositories/sonar"
WORKDIR /usr/course/repositories/sonar
RUN git  clone https://github.com/digininja/DVWA
RUN mkdir -p "/usr/course/repositories/snyk"
WORKDIR /usr/course/repositories/snyk
RUN git clone https://github.com/marcosechague/xvwa.git
RUN mkdir -p "/usr/course/repositories/bach"
WORKDIR /usr/course/repositories/bach
RUN git clone https://github.com/xthk/fake-vulnerabilities-php-composer.git

RUN mkdir -p "/opt/sonar-scanner"
WORKDIR /opt/sonar-scanner
COPY  sonar-scanner .
ENV PATH="/opt/sonar-scanner/bin:${PATH}"

RUN apt-get -y install telnet

WORKDIR /usr/course
CMD ["bash"]
