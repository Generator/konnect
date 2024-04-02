#!/bin/sh

PUID=${PUID:-1000}
PGID=${PGID:-1000}
USERNAME="konnect"

# Add local user
addgroup -S -g $PGID $USERNAME
adduser -S -D -H -h /app -u $PUID -G $USERNAME $USERNAME

NAME=${NAME:-localhost}
ADMIN_PORT=${ADMIN_PORT:-8080}
DISCOVER_PORT=${DISCOVER_PORT:-1716}
SERIVE_PORT=${SERVE_PORT:-1764}
TRANSFER_PORT=${TRANSFER_PORT:-1763}
MAX_TRANSFER_PORTS=${MAX_TRANSFER_PORTS:-3}
CONFIG_DIR="/config"

mkdir -p "$CONFIG_DIR"
chown -R "$PUID":"$PGID" "$CONFIG_DIR"

echo "Starting with UID: $PUID, GID: $PGID"

su-exec "$USERNAME" /usr/local/bin/konnectd --name "$NAME" \
    --admin-port "$ADMIN_PORT" \
    --discovery-port "$DISCOVER_PORT" \
    --service-port "$SERIVE_PORT" \
    --transfer-port "$TRANSFER_PORT" \
    --max-transfer-ports "$MAX_TRANSFER_PORTS" \
    --config-dir "$CONFIG_DIR" \
    "$@"