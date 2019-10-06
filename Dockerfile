FROM apfohl/service-base:latest

# General
RUN apk update

# NGINX
RUN addgroup -S www-data && adduser -S www-data -G www-data
RUN apk add --no-cache nginx
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/supervisord.conf /etc/supervisord.d/nginx.conf

# PHP-FPM
RUN apk add --no-cache php7-fpm php7-session php7-json
COPY php-fpm/php-fpm.conf /etc/php7/php-fpm.conf
COPY php-fpm/www.conf /etc/php7/php-fpm.d/www.conf
COPY php-fpm/supervisord.conf /etc/supervisord.d/php-fpm.conf

# DokuWiki
ADD https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz /
RUN tar xf dokuwiki-stable.tgz
RUN rm dokuwiki-stable.tgz
RUN mv dokuwiki-* /usr/local/share/dokuwiki
RUN chown -R root:root /usr/local/share/dokuwiki
RUN chown -R root:www-data /usr/local/share/dokuwiki/data /usr/local/share/dokuwiki/conf
RUN chmod -R g+w /usr/local/share/dokuwiki/data /usr/local/share/dokuwiki/conf
RUN mkdir -p /init
RUN mv /usr/local/share/dokuwiki/data /init
RUN mv /usr/local/share/dokuwiki/conf /init
COPY dokuwiki/nginx.conf /etc/nginx/conf.d/dokuwiki.conf

# Boot
COPY boot/* /boot.d/

# Network
EXPOSE 80/tcp
