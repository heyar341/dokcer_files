FROM php:7.4-fpm

# install composer
RUN cd /usr/bin && curl -s http://getcomposer.org/installer | php && ln -s /usr/bin/composer.phar /usr/bin/composer
RUN apt-get update \
&& apt-get install -y \
git \
zip \
unzip \
vim \
#for gd
libfreetype6-dev \
libjpeg62-turbo-dev \
libpng-dev \
libwebp-dev \
libxpm-dev \
#gd
&& docker-php-ext-install -j$(nproc) iconv \
&& docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd \
#execでコンテナの中に入ってgit commitしてたけど、ソースはローカルだから作業はexcでコンテナに入らなくていいから、日本語対応している必要ない
&& apt-get update \
&& apt-get install -y \
locales \
&& locale-gen ja-JP.UTF-8 \
&& localedef -f UTF-8 -i ja_JP ja_JP \
&& apt-get update \
&& apt-get install -y libpq-dev \
&& docker-php-ext-install pdo_mysql pdo_pgsql \
&& curl -sL https://deb.nodesource.com/setup_13.x | bash - \
&& apt-get update \
&&apt-get install -y nodejs

WORKDIR /var/www/html