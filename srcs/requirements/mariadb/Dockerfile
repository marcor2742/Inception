FROM debian:bullseye

RUN apt update && apt upgrade -y && \
    apt-get install mariadb-server -y && \
    apt install -y vim \
                    curl
	&& apt clean

EXPOSE 3306

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mysql.sh /

RUN chmod +x /mysql.sh


CMD [ "sh","/mysql.sh" ]