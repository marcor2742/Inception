FROM debian:bullseye

RUN apt update && apt upgrade -y && \
    apt-get install mariadb-server -y && \
    apt install -y vim \
                    curl \
    && apt clean

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mysql.sh /
ENV SQL_DATABASE=databasemruggier
ENV SQL_USER=mruggier
ENV SQL_PASSWORD=123
ENV SQL_ROOT_PASSWORD=123

RUN chmod +x /mysql.sh

CMD [ "sh","/mysql.sh" ]