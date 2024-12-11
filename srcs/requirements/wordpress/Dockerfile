FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y wget \
						vim \
						php7.4 \
						php7.4-fpm \
						php7.4-mysql \
						mariadb-client \
	&& apt-get clean

# RUN wget https://wordpress.org/wordpress-6.7.1.tar.gz -P /var/www

# RUN cd /var/www && tar -xzvf wordpress-6.7.1.tar.gz && rm wordpress-6.7.1.tar.gz

# RUN	chown -R root:root /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /usr/local/bin
RUN chmod +x /usr/local/bin/wp-cli.phar && mv /usr/local/bin/wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/setup.sh /tmp
RUN chmod +x /tmp/setup.sh

RUN mkdir -p /var/www/wordpress

WORKDIR /var/www/wordpress

EXPOSE 9000

ENTRYPOINT [ "sh", "/tmp/setup.sh" ]