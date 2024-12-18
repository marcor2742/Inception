FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt-get install -y wget default-mysql-client curl

RUN wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh && \
    sh /tmp/netdata-kickstart.sh --stable-channel --claim-token EJD5gf_5pGusjYF6wAhglVZugiN6a6BXqTxSUaZAwyXCeAANMrrdk4EF8IxBGsxdX3OtpnDEXg1Got2mSVyVkc0Zb6eFL2RmLLJ9wQ2iG2jIJ3SqTJF-loxV1ruEfJiEWWeL0Cg --claim-rooms cc8e40d5-f3e4-4377-b968-719d98754c13[netdata_agent_local] --claim-url https://app.netdata.cloud

#COPY ./tools/script.sh /
#
#RUN chmod +x /script.sh
#
#CMD ["/script.sh"]

CMD ["netdata", "-D"]