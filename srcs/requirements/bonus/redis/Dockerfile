FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y redis-server \
						vim \
	&& apt-get clean

EXPOSE 6379

CMD [ "redis-server", "--bind", "0.0.0.0", "--port", "6379", "--protected-mode", "no"]