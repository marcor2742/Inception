FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y netdata \
						netcat \
						procps \
						vim

RUN sed -i 's/bind socket to IP = 127.0.0.1/bind socket to IP = 0.0.0.0/' /etc/netdata/netdata.conf

EXPOSE 19999

CMD [ "/usr/sbin/netdata", "-D"]