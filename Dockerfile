FROM debian:latest

ENV CADDY_VERSION 0.11.0
ADD https://github.com/mholt/caddy/releases/download/v0.11.0/caddy_v${CADDY_VERSION}_linux_amd64.tar.gz /src/
RUN tar xzf /src/caddy_v${CADDY_VERSION}_linux_amd64.tar.gz

RUN useradd -u 9999 caddy

FROM scratch
COPY Caddyfile /etc/Caddyfile
COPY --from=0 /caddy /caddy
COPY --from=0 /etc/passwd /etc/passwd

VOLUME /srv

EXPOSE 8888

USER caddy
CMD ["/caddy", "-log", "stdout", "-conf=/etc/Caddyfile"]
