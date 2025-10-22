FROM alpine:3.21

RUN apk add --no-cache ca-certificates wget

RUN wget -O /usr/local/bin/cadvisor \
    https://github.com/google/cadvisor/releases/download/v0.49.1/cadvisor-v0.49.1-linux-amd64 \
    && chmod +x /usr/local/bin/cadvisor

EXPOSE 8082

ENTRYPOINT ["cadvisor"]
