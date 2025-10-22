FROM alpine:3.21

RUN apk add --no-cache wget \
    php php-session php-mysqli \
    && mkdir /var/www

WORKDIR /var/www

RUN wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -O adminer.php

EXPOSE 8081

CMD ["php", "-S", "0.0.0.0:8081"]
