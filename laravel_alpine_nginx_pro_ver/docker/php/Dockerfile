
#最終ステージ
#-------------------------
FROM base_image:ver1 as base

FROM php:7.4-fpm-alpine3.10

RUN apk --no-cache update \
&& apk --no-cache add \
git \
zip \
zlib-dev \
unzip \
#gd用パッケージ
freetype \
freetype-dev \
libjpeg-turbo \
libjpeg-turbo-dev \
libpng \
libpng-dev \
libwebp-dev \
libxpm-dev \
#Timezone用パッケージ
tzdata \
&& cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
#database関係
&& docker-php-ext-install pdo_mysql \
#gd関係
&& docker-php-ext-install -j$(nproc) iconv \
&& docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd

ENV LANG ja_JP.utf8

COPY --from=base /var/www/html/freegram /var/www/html/freegram

WORKDIR /var/www/html/freegram
#         ↓=Rオプションがないとnginxから書き込みできない
RUN chown -R www-data:www-data storage \
&& chown -R www-data:www-data bootstrap/cache \
&& chmod -R 775 storage \
&& chmod -R 775 bootstrap/cache 
USER www-data