#!/usr/bin/env bash
set -euo pipefail

for bundle in admin player; do
  target="/app/public/$bundle"
  default="/opt/sonn-public/$bundle"

  mkdir -p "$target"
  if [ ! -e "$target/index.html" ] && [ -d "$default" ]; then
    cp -a "$default/." "$target/"
  fi
done

exec node /app/dist/server.js
