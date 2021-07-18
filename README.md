# docker-alpine-crond

Simple crond docker image that allows you run crons

## Usage

```
docker run --rm -it --name crond crond -c '*/15 * * * * echo "ping"'
# You can also specify cron schedules using the `CRON_SHEDULE` env var:
docker run --rm --name crond -e CRON_SHEDULE='*/15 * * * * echo "ping"' ghcr.io/hoshsadiq/crond:latest
# You can even combine them
docker run --rm --name crond -e CRON_SHEDULE='*/15 * * * * echo "ping"' ghcr.io/hoshsadiq/crond:latest -c '*/15 * * * * echo "ping"'
```

You should mount directories or scripts or whatnot accordingly. There's a dedicated `/scripts` volume for scripts.

The user running the cron is user 1000, with gid 1000. You should make changes accordingly. If you'd like a different uid/gid, feel free to clone this repository and use a different UID/GID as build args.
