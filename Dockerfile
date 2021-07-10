FROM docker.io/library/alpine:latest

RUN apk add --no-cache freeradius freeradius-eap openssl

COPY etc/raddb/mods-available/eap /etc/raddb/mods-available/eap
COPY etc/raddb/radiusd.conf /etc/raddb/radiusd.conf

RUN mkdir -m700 /tmp/radiusd && chown radius:radius /tmp/radiusd
RUN chgrp -R radius /etc/raddb
RUN rm -rf /etc/raddb/certs && mkdir -m700 /etc/raddb/certs && chown radius:radius /etc/raddb/certs

VOLUME ["/etc/raddb/certs"]
EXPOSE 1812/udp

USER radius
ENTRYPOINT ["/usr/sbin/radiusd"]
CMD ["-f", "-l", "stdout", "-x"]
