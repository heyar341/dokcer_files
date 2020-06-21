#最初のステージ
#---------------------------
#composerで結局php artisan migrateとか使うから、最終ステージに入れなきゃダメ
#というのは間違いでphp artisanはcomposer関係ない
FROM composer:1.10 as builder1

#ソースファイルのコピー
WORKDIR /var/www/html
RUN mkdir freegram
COPY ./freegram /var/www/html/freegram

#書き込み可能にする
RUN chmod +w /var/www/html/freegram

# パッケージインストール
# git colone後の初期設定
WORKDIR /var/www/html/freegram
RUN composer install --no-dev \
&&php artisan key:generate

#２番目のステージ
#--------------------------
FROM node:13-alpine3.10 as node

WORKDIR /var/www/html
RUN mkdir freegram
COPY --from=builder1 /var/www/html/freegram /var/www/html/freegram

WORKDIR /var/www/html/freegram

RUN npm install \
&& npm rebuild node-sass \
&& npm run prod