FROM php:7.4-fpm-alpine3.11

# install composer
RUN cd /usr/bin \
&& curl -s http://getcomposer.org/installer | php \
&& ln -s /usr/bin/composer.phar /usr/bin/composer
RUN apk --no-cache update \
&& apk --no-cache add \
git \
zip \
zlib-dev \
unzip \
vim \
nodejs \
nodejs-npm \
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

WORKDIR /var/www/html