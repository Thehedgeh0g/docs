#!/usr/bin/env bash

set -o errexit

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
PHAN_VERSION=5.3.0

function install_with_apt() {
    apt-get -qq install -y "$@"
}

#Установка библиотек и расширений
function build_php_extensions() {
    apt-get update && apt-get install -y \
        libicu-dev \
        libzip-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libonig-dev \
        libldap2-dev \
        zlib1g-dev \
        curl \
        gnupg \
        ca-certificates


    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap
    docker-php-ext-configure gd --with-jpeg --with-freetype && \
    docker-php-ext-install gd intl pdo_mysql mysqli zip

    ln -s /usr/local/bin/php /usr/bin/php
}

# Установка nodejs
function setup_nodejs {
    curl  -fsSL --silent --location https://deb.nodesource.com/setup_18.x | bash
    install_with_apt nodejs
    npm config set cache "$CACHE_DIR/.npm" --global
}

function cleanup_docker_image() {
    # See also https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
    apt-get -qq clean
    truncate -s 0 /var/log/*log
}

setup_phan() {
    local URL=https://github.com/phan/phan/releases/download/$PHAN_VERSION/phan.phar
    curl --silent --location "$URL" -o "/usr/bin/phan"
    chmod +x "/usr/bin/phan"
}

function install_tools() {
    install_with_apt --no-install-recommends \
        sudo
}

apt-get -qq update

build_php_extensions
setup_nodejs
setup_phan
install_tools

cleanup_docker_image

# Remove this script
rm $(readlink -f $0)