FROM base_image:ver1 as base

FROM nginx:1.16.1-alpine

COPY --from=base /var/www/html/freegram/public /var/www/html/freegram/public