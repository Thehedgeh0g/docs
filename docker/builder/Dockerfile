FROM harbor.ispring.lan/vendor/php:8.1.13-cli-buster

ADD --chmod=+x docker/builder/docker-setup.sh /usr/bin/docker-setup.sh

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN /usr/bin/docker-setup.sh