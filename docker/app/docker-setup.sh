#!/usr/bin/env bash

# exit on any error
set -e

# Environment
export USE_X_DEBUG_ENV_VAR=$USE_X_DEBUG

# Configuration values
APT_DISTRO_NAME=buster

# avoid interactive questions when installing packages
export DEBIAN_FRONTEND=noninteractive

function cleanup_docker_image() {
    # See also https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
    apt-get -qq clean
    truncate -s 0 /var/log/*log
}

add_apt_repository() {
    local FILENAME=/etc/apt/sources.list.d/$1.list
    local URL=$2
    local SECTION=$3
    echo "deb $URL $APT_DISTRO_NAME $SECTION" >"$FILENAME"
}

# Функция для установки OpenResty
install_nginx() {
    apt-get -qq update

    # Установка Nginx
    apt-get -qq install -y --no-install-recommends nginx

    # Создание символической ссылки для конфигурации Nginx
    ln -s /etc/nginx /etc/nginx/conf.d/

    # Создание директории для логов Nginx
    mkdir -p /var/log/nginx/
    chown www-data:www-data /var/log/nginx/
}


install_tools() {
    apt-get -qq update
    apt-get -qq install -y --no-install-recommends \
        sudo \
        jq
}

install_runtime_deps() {
    # Install runtime dependencies of PHP extensions
    apt-get -qq install --yes --no-install-recommends \
        libzip4 \
        libpng16-16
}

build_php_extensions() {
    # install build deps
    apt-get -qq install --yes --no-install-recommends \
        zlib1g-dev \
        libzip-dev \
        libjpeg-dev \
        libldap2-dev \
        libpng-dev \
        sphinxsearch \
        curl \
        gnupg \
        ca-certificates

    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap
    docker-php-ext-configure gd --with-jpeg
    docker-php-ext-install "-j$(nproc)" gd
    docker-php-ext-install "-j$(nproc)" zip
    docker-php-ext-install "-j$(nproc)" mysqli
    docker-php-ext-install "-j$(nproc)" pdo_mysql

    # remove build dependencies
    apt-get purge --auto-remove --yes \
      zlib1g-dev \
      libzip-dev \
      libpng-dev

    ln -s /usr/local/bin/php /usr/bin/php
}

# Installs tools useful during bash session in container
install_debugging_tools() {
    apt-get -qq install --yes --no-install-recommends \
        mc \
        nano \
        less
}

# Install xdebug
install_xdebug() {
    pecl install xdebug-3.2.2
    docker-php-ext-enable xdebug
}

cleanup() {
    # See also https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
    apt-get -qq clean
    rm -rf /usr/src/
    truncate -s 0 /var/log/*log
}

apt-get -qq update

#build_php_extensions

cleanup_docker_image

install_tools
build_php_extensions
install_runtime_deps
install_debugging_tools
install_nginx
if [[ "$USE_X_DEBUG_ENV_VAR" = "yes" ]]; then
    install_xdebug
fi

cleanup

# Remove this script
rm "$(readlink -f "$0")"
