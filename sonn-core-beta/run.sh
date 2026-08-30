#!/usr/bin/env bash
set -euo pipefail

log() {
  printf '%s\n' "$*"
}

# Prefix every log line (including sonn-core's own output) with a
# timestamp, since this app does not otherwise add one.
exec > >(while IFS= read -r line; do printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$line"; done) 2>&1

# Home Assistant provides each app with a private, persistent /data folder
# that survives restarts, rebuilds, and updates (and is included in app
# backups). sonn-core keeps its configuration under /app/data, so make that
# a symlink into the persistent folder.

if [ -d /opt/sonn-data-default ] && [ -z "$(ls -A /data 2>/dev/null)" ]; then
  log "Seeding /data with default sonn-core state"
  # Ownership is not preserved because /data may not support chown.
  cp -a --no-preserve=ownership /opt/sonn-data-default/. /data/
fi

log "Linking /app/data to /data"
rm -rf /app/data
ln -s /data /app/data

log "Starting sonn-core"
exec node /app/dist/server.js
