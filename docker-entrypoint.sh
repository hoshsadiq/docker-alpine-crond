#!/usr/bin/env sh

set -eu

get_schedules() {
  if [ -n "${CRON_SCHEDULE:-}" ]; then
    printf '%s\n' "$CRON_SCHEDULE"
  fi
  while [ $# -gt 0 ]; do
    key="$1"

    case $key in
    -c | --cron)
      printf '%s\n' "${2}"
      shift
      shift
      ;;
    *)
      shift
      ;;
    esac
  done
}

main() {
  crontab="$(get_schedules "$@")"
  if [ -z "${crontab:-}" ]; then
    printf >&2 "cron schedule was empty. Nothing to do.\n"
    exit 1
  fi

  echo "${crontab}" | crontab -u "$CRON_USER" -

  crontab -l -u "$CRON_USER"

  exec crond -f -L /dev/stdout
}

main "$@"
