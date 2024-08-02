FROM alpine:3.20

RUN apk update && apk add socat

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /

ENV PROTOCOL='not-set'
ENV LISTEN_PORT='not-set'
ENV REMOTE_HOST='remote.host.not.set'
ENV REMOTE_PORT='not-set'

ENTRYPOINT /entrypoint.sh 
