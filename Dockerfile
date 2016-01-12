FROM alpine:3.2
MAINTAINER Abiola Ibrahim <abiola89@gmail.com>

LABEL caddy_version="0.8" architecture="amd64"

RUN apk add --update openssh-client git tar

RUN mkdir /caddysrc \
&& curl -sL -o /caddysrc/caddy_linux_amd64.tar.gz "http://caddyserver.com/download/build?os=linux&arch=amd64&features=git" \
&& tar -xf /caddysrc/caddy_linux_amd64.tar.gz -C /caddysrc \
&& mv /caddysrc/caddy /usr/bin/caddy \
&& chmod 755 /usr/bin/caddy \
&& rm -rf /caddysrc \
&& printf "0.0.0.0\nbrowse" > /etc/Caddyfile

RUN apk add --update perl \
&& curl -sL -o /tmp/hugo.tgz "https://github.com/spf13/hugo/releases/download/v0.15/hugo_0.15_linux_amd64.tar.gz" \
&& tar -xf /tmp/hugo.tgz -C /tmp/ \
&& mv /tmp/hugo_0.15_linux_amd64/hugo_0.15_linux_amd64 /usr/local/bin/hugo

RUN mkdir /srv

EXPOSE 2015
EXPOSE 443
EXPOSE 80

WORKDIR /srv

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile"]
