FROM alpine:3.16.2

# Inspiration from https://github.com/gmr/alpine-pgbouncer/blob/master/Dockerfile
# hadolint ignore=DL3003,DL3018
RUN \
  apk add -U --no-cache --upgrade busybox pgbouncer==1.17.0-r0 && \
  touch /etc/pgbouncer/userlist.txt && \
  touch /var/run/pgbouncer && \
  addgroup -g 70 -S postgres 2>/dev/null && \
  adduser -u 70 -S -D -H -h /var/lib/postgresql -g "Postgres user" -s /bin/sh -G postgres postgres 2>/dev/null && \
  chown -R postgres /var/run/pgbouncer /etc/pgbouncer

COPY entrypoint.sh /entrypoint.sh
USER postgres
EXPOSE 5432
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/pgbouncer", "/etc/pgbouncer/pgbouncer.ini"]
