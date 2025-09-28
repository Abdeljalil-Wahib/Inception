FROM debian:bullseye

# Add mariadb-client here
RUN apt-get update && \
    apt-get install -y mariadb-server procps mariadb-client

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/configure.sh /usr/local/bin/configure.sh

RUN chmod +x /usr/local/bin/configure.sh

ENTRYPOINT [ "configure.sh" ]

CMD ["mysqld_safe"]