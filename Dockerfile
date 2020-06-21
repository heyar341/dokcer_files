#最初のステージ
#---------------------------
FROM composer:1.10 as builder1

#ソースファイルのコピー
WORKDIR /var/www/html
COPY ./laravel-project /var/www/html

#書き込み可能にする
RUN chmod +w /var/www/html

#パッケージインストール
#git colone後の初期設定
RUN composer install --no-dev \
&&phpartisan key:generate

#２番目のステージ
#--------------------------
FROM node:13-alpine3.11 as node

COPY --from=builder1 /var/www/html /var/www/html

WORKDIR /var/www/html

RUN npm install \
&& npm rebuild node-sass \
&& npm run pro

RUN rm -rf ./node_modules

#最終ステージ
#-------------------------
FROM php:7.4-fpm-alpine3.11

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

WORKDIR /var/www/html



