FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y nodejs \
						npm \
						netcat \
						vim

WORKDIR /usr/src/app

COPY tools .

RUN npm install -y express

EXPOSE 3000

ENTRYPOINT ["node", "server.js"]