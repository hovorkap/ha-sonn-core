#!/usr/bin/env bash
set -euo pipefail

CONFIG_ROOT=/config
DATA_DIR="$CONFIG_ROOT/data"
PUBLIC_DIR="$CONFIG_ROOT/public"
MIGRATION_MARKER="$CONFIG_ROOT/.layout-v2"

mkdir -p "$DATA_DIR" "$PUBLIC_DIR"

# Earlier versions of this app mapped the same host folder at both
# /app/data and /app/public, which merged their contents into one shared
# directory. Split that legacy, merged layout into separate data/ and
# public/ subdirectories the first time this runs, using the pristine
# bundled public file list to decide where each entry belongs.
if [ ! -f "$MIGRATION_MARKER" ]; then
  shopt -s dotglob nullglob
  for entry in "$CONFIG_ROOT"/*; do
    name="$(basename "$entry")"
    case "$name" in
      data|public)
        continue
        ;;
    esac
    if [ -e "/opt/sonn-public/$name" ]; then
      mv "$entry" "$PUBLIC_DIR/$name"
    else
      mv "$entry" "$DATA_DIR/$name"
    fi
  done
  shopt -u dotglob nullglob
  touch "$MIGRATION_MARKER"
fi

# Seed defaults on first run (empty persistent folders).
if [ -d /opt/sonn-data ] && [ -z "$(ls -A "$DATA_DIR" 2>/dev/null)" ]; then
  cp -a /opt/sonn-data/. "$DATA_DIR/"
fi
if [ -d /opt/sonn-public ]; then
  cp -an /opt/sonn-public/. "$PUBLIC_DIR/"
fi

rm -rf /app/data /app/public
ln -s "$DATA_DIR" /app/data
ln -s "$PUBLIC_DIR" /app/public

exec node /app/dist/server.js
