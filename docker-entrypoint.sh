#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
	set -- btb_oneshot "$@"
fi

# Allow the container to be started with `--user`, if running as root drop privileges
if [ "$1" = 'btb_oneshot' -a "$(id -u)" = '0' ]; then
	chown -R bitbi .
	exec gosu bitbi "$0" "$@"
fi

# If not root (i.e. docker run --user $USER ...), then run as invoked
exec "$@"

