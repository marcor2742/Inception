FROM debian:bullseye

RUN apt update && apt upgrade -y && \
	apt install -y nginx \
					vim \
					curl \
					openssl \
	&& apt clean

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=IT/ST=Tuscany/L=Florence/O=42/OU=42/CN=login.42.fr/UID=login"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD [ "nginx", "-g", "daemon off;" ]