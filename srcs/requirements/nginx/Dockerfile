FROM alpine:3.21

RUN apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/certs

RUN openssl req -x509 -newkey rsa:4096 \
    -keyout /etc/nginx/certs/incep.key \
    -out /etc/nginx/certs/incep.crt \
    -sha256 -days 365 -nodes \
    -subj "/C=MA/ST=Marrakech/L=Bengruir/O=Laoubaid/OU=Inception/CN=laoubaid.42.fr"

COPY tools/nginx.conf /etc/nginx/nginx.conf
COPY tools/index.html /var/www/wordpress/index.html

RUN chmod 600 /etc/nginx/certs/incep.key \
    && chmod 644 /etc/nginx/certs/incep.crt \
    && chown -R nginx:nginx /etc/nginx/certs

EXPOSE 443

ENTRYPOINT ["nginx"]
