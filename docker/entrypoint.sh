#!/bin/sh

PUID=${PUID:-1000}
PGID=${PGID:-1000}
USERNAME="konnect"

# Add local user
addgroup -S -g $PGID $USERNAME
adduser -S -D -H -h /app -u $PUID -G $USERNAME $USERNAME

NAME=${NAME:-localhost}
MAX_TRANSFER_PORTS=${MAX_TRANSFER_PORTS:-3}
CONFIG_DIR="/config"

mkdir -p "$CONFIG_DIR"
chown -R "$PUID":"$PGID" "$CONFIG_DIR"

echo "Starting with UID: $PUID, GID: $PGID"

su-exec "$USERNAME" /usr/local/bin/konnectd --name "${NAME:-konnect}" \
    --max-transfer-ports "$MAX_TRANSFER_PORTS" \
    --config-dir "$CONFIG_DIR" \
    "$@"