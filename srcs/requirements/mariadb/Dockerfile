FROM debian:12

RUN apt-get update && \
    apt-get install -y mariadb-server

RUN mkdir -p /var/run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql

COPY init_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_db.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/init_db.sh"]
