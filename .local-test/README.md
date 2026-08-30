# Local test harness for sonn-core-beta

This folder is **not** part of the app itself — it's a local-only helper for
testing the `sonn-core-beta` image on your machine before pushing changes,
without needing a real Home Assistant instance.

It simulates the two things Home Assistant's Supervisor does for this app:

- Mounts a persistent Docker volume at `/data` inside the container, the same
  way Supervisor mounts the app's private, persistent data folder.
- Rebuilds/recreates the container while keeping that volume, the same way
  Supervisor does on an app "rebuild" or update.

It does **not** simulate AppArmor confinement (Docker Desktop / Rancher
Desktop on macOS does not support AppArmor), so this cannot catch AppArmor
policy bugs like the "Permission denied" issue fixed in `4.0.0-beta.20-r1`.
Always double check real config/AppArmor changes against an actual HA
Supervisor install before considering them verified.

## Usage

```sh
cd .local-test

# Build the image from sonn-core-beta/Dockerfile
./test.sh build

# Start a fresh container + fresh named volume (simulates first install)
./test.sh start

# Show recent logs (timestamps should be present)
./test.sh logs

# Restart the running container (simulates an HA app restart)
./test.sh restart

# Remove and recreate the container, but KEEP the volume
# (simulates hitting "Rebuild" in the HA app page)
./test.sh rebuild

# Show what's currently inside the persistent /data volume
./test.sh inspect-data

# Stop and remove the container AND the volume (simulates full uninstall)
./test.sh clean
```

After `start`, `restart`, or `rebuild`, the web UI should be reachable at
<http://localhost:7090>. Check `test.sh inspect-data` after each step to
confirm `config.json` (and anything else sonn-core writes) is still present
and unchanged aside from expected updates.

## What to verify

1. **Startup**: `./test.sh build && ./test.sh start && ./test.sh logs` — no
   `Permission denied` or other errors; the web UI responds.
2. **Restart persistence**: change something in the sonn-core UI (e.g. a
   setting), `./test.sh restart`, confirm the change is still there and
   `inspect-data` shows the same files.
3. **Rebuild persistence**: same as above but with `./test.sh rebuild`, which
   destroys and recreates the container (closer to what HA's "Rebuild"
   button does) while keeping the volume.
4. **Fresh install**: `./test.sh clean && ./test.sh start` — should seed
   `/data` from the image's default state and start with no prior config.
