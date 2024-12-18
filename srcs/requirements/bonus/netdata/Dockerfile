FROM debian:bullseye

ARG NETDATA_CLAIM_TOKEN
ARG NETDATA_CLAIM_ROOMS
ARG NETDATA_CLAIM_URL

RUN apt update -y && apt upgrade -y

RUN apt-get install -y wget default-mysql-client curl netcat

RUN wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh && \
    sh /tmp/netdata-kickstart.sh --stable-channel --claim-token ${NETDATA_CLAIM_TOKEN} --claim-rooms ${NETDATA_CLAIM_ROOMS} --claim-url ${NETDATA_CLAIM_URL}

RUN sed -i 's/bind socket to IP = 127.0.0.1/bind socket to IP = 0.0.0.0/' /etc/netdata/netdata.conf

# Crea il file di configurazione cloud
RUN mkdir -p /var/lib/netdata/cloud.d && \
    echo "[global]" > /var/lib/netdata/cloud.d/cloud.conf && \
    echo "claim_token = ${NETDATA_CLAIM_TOKEN}" >> /var/lib/netdata/cloud.d/cloud.conf && \
    echo "rooms = ${NETDATA_CLAIM_ROOMS}" >> /var/lib/netdata/cloud.d/cloud.conf && \
    echo "claim_url = ${NETDATA_CLAIM_URL}" >> /var/lib/netdata/cloud.d/cloud.conf

CMD ["netdata", "-D"]