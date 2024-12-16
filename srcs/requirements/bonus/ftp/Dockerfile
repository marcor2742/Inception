FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y vim \
					netcat \
					vsftpd \
	&& apt-get clean

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/ftp.sh /

RUN chmod +x /ftp.sh

CMD ["sh", "/ftp.sh"]