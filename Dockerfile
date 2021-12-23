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

## Install libpng12
RUN add-apt-repository ppa:linuxuprising/libpng12
RUN apt-get clean && apt-get update
RUN apt-get install -y --no-install-recommends libpng12-0

## Add php repository
RUN add-apt-repository ppa:ondrej/php -y

## Add git repository
RUN add-apt-repository ppa:git-core/ppa -y

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn -y
RUN yarn --version

## Installs PHP
RUN apt-get update && apt-get install -y --no-install-recommends php7.4-cli 
	

## Upgrades
RUN apt-get dist-upgrade -y

## Install node and npm
RUN apt-get update && apt-get install -y nodejs npm

## Install Snyk cli
RUN npm install snyk@latest -g
RUN mkdir -p /usr/Programs

## Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

## Add composer bin to PATH
ENV PATH "$PATH:$HOME/.composer/vendor/bin"

## Install composer plugins
#RUN /usr/local/bin/composer global require "laravel/envoy:^1.4"
