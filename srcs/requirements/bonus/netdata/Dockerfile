FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt-get install -y wget default-mysql-client curl

RUN wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh && sh /tmp/netdata-kickstart.sh --no-updates --stable-channel --disable-telemetry

# COPY ./conf/netdata.conf /etc/netdata/netdata.conf

# COPY ./conf/stream.conf /etc/netdata/stream.conf

# CMD ["netdata", "-D"]

COPY ./tools/script.sh /

RUN chmod +x /script.sh

CMD ["/script.sh"]