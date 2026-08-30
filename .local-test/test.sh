#!/usr/bin/env bash
# Local test harness for the sonn-core-beta app image.
# See README.md in this folder for usage and what this does/does not verify.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

APP_DIR="../sonn-core-beta"
IMAGE="sonn-core-beta-local:test"
CONTAINER="sonn-core-beta-local"
VOLUME="sonn-core-beta-local-data"
PORT=7090

usage() {
  cat <<EOF
Usage: $0 <command>

Commands:
  build           Build the app image from $APP_DIR
  start           Start a fresh container (creates the volume if missing)
  logs            Follow container logs
  restart         Restart the running container (docker restart)
  rebuild         Remove and recreate the container, keeping the volume
  inspect-data    List the contents of the persistent /data volume
  shell           Open a shell inside the running container
  clean           Stop/remove the container AND the persistent volume
EOF
}

build() {
  docker build -t "$IMAGE" "$APP_DIR"
}

start() {
  docker volume create "$VOLUME" >/dev/null
  docker rm -f "$CONTAINER" >/dev/null 2>&1 || true
  docker run -d \
    --name "$CONTAINER" \
    -p "${PORT}:${PORT}" \
    -p 7091:7091 \
    -p 7095:7095 \
    -v "${VOLUME}:/data" \
    "$IMAGE"
  echo "Started. Web UI: http://localhost:${PORT}"
}

logs() {
  docker logs -f --tail 200 "$CONTAINER"
}

restart_container() {
  docker restart "$CONTAINER"
  echo "Restarted. Web UI: http://localhost:${PORT}"
}

rebuild_container() {
  docker rm -f "$CONTAINER" >/dev/null 2>&1 || true
  docker run -d \
    --name "$CONTAINER" \
    -p "${PORT}:${PORT}" \
    -p 7091:7091 \
    -p 7095:7095 \
    -v "${VOLUME}:/data" \
    "$IMAGE"
  echo "Recreated container (volume kept). Web UI: http://localhost:${PORT}"
}

inspect_data() {
  docker run --rm -v "${VOLUME}:/data" alpine:3 sh -c \
    "echo '--- /data tree ---' && find /data -maxdepth 3 | sort"
}

shell() {
  docker exec -it "$CONTAINER" /bin/bash
}

clean() {
  docker rm -f "$CONTAINER" >/dev/null 2>&1 || true
  docker volume rm "$VOLUME" >/dev/null 2>&1 || true
  echo "Removed container and volume."
}

case "${1:-}" in
  build) build ;;
  start) start ;;
  logs) logs ;;
  restart) restart_container ;;
  rebuild) rebuild_container ;;
  inspect-data) inspect_data ;;
  shell) shell ;;
  clean) clean ;;
  *) usage; exit 1 ;;
esac
