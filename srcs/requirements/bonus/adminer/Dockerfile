FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y wget \
						netcat \
						vim \
						php7.4 \
						php7.4-fpm \
						php7.4-mysql \
						adminer \
	&& apt-get clean

RUN wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer.php

RUN mkdir -p /run/php && chown www-data:www-data /run/php

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9001

CMD ["php-fpm7.4", "-F"]