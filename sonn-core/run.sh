#!/usr/bin/env bash
set -euo pipefail

mkdir -p /app/public
if [ -d /opt/sonn-public ]; then
  cp -an /opt/sonn-public/. /app/public/
fi

exec node /app/dist/server.js
