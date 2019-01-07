FROM alpine:3.6

ARG BUILD_DATE
ARG VCS_REF

RUN set -e \
  && apk add --no-cache \
  curl \
  git \
  patch \
  php7 \
  php7-apcu \
  php7-ctype \
  php7-json \
  php7-mbstring \
  php7-opcache \
  php7-openssl \
  php7-phar \
  php7-simplexml \
  php7-tokenizer \
  php7-xmlwriter \
  php7-zlib \
  php7-xml \
  php7-dom \
  && curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin \
  && composer global require phpmd/phpmd \
  && ln -s /root/.composer/vendor/bin/phpmd /usr/bin/phpmd \
  && apk del --no-cache git \
  && rm -rf /root/.composer/cache/* \
  && sed -i "s/.*memory_limit = .*/memory_limit = -1/" /etc/php7/php.ini

VOLUME /work
WORKDIR /work

CMD ["phpmd", "."]