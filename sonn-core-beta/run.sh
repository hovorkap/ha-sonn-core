#!/usr/bin/env bash
set -euo pipefail

# Home Assistant provides each app with a private, persistent /data folder
# that survives restarts, rebuilds, and updates (and is included in app
# backups). sonn-core keeps its configuration under /app/data, so make that
# a symlink into the persistent folder.

if [ -d /opt/sonn-data-default ] && [ -z "$(ls -A /data 2>/dev/null)" ]; then
  # First run: seed the persistent folder with the image's default state.
  # Ownership is not preserved because /data may not support chown.
  cp -a --no-preserve=ownership /opt/sonn-data-default/. /data/
fi

rm -rf /app/data
ln -s /data /app/data

exec node /app/dist/server.js
