FROM debian:12

RUN apt update && apt install php-fpm \
    php-mysql php-gd php-mbstring \
    curl mariadb-client -y

COPY www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp

WORKDIR /var/www/wordpress

COPY init_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_wp.sh

ENTRYPOINT ["/usr/local/bin/init_wp.sh"]
