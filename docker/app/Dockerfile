FROM harbor.ispring.lan/vendor/php:8.1.13-fpm-buster

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV USE_X_DEBUG "yes"

COPY ./docker/app/docker-setup.sh /usr/bin/
RUN /usr/bin/docker-setup.sh

COPY ./ /usr/local/www/docs/hugo_pages_editor

COPY config/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --chown=www-data:www-data ./config/php/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

WORKDIR /usr/local/www/docs/hugo_pages_editor

ENTRYPOINT ["/usr/local/www/docs/hugo_pages_editor/bin/docker-entrypoint"]
