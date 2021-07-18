FROM alpine:3.14

ARG DATE
ARG PROJECT_NAME
ARG FULL_COMMIT
ARG VERSION

LABEL org.opencontainers.image.created=$DATE
LABEL org.opencontainers.image.name=$PROJECT_NAME
LABEL org.opencontainers.image.revision=$FULL_COMMIT
LABEL org.opencontainers.image.version=$VERSION

ARG CRON_USER=crond
ARG CRON_UID=1000
ARG CRON_GID=1000

RUN set -eux; \
    apk add --no-cache socat busybox-suid; \
    addgroup -g $CRON_GID -S $CRON_USER; \
    adduser -u $CRON_UID -D -S -G $CRON_USER $CRON_USER; \
    touch /var/run/crond.pid; \
    chgrp crond /var/run/crond.pid

ENV CRON_USER=$CRON_USER

COPY docker-entrypoint.sh /docker-entrypoint.sh

VOLUME /scripts

ENTRYPOINT ["/docker-entrypoint.sh"]