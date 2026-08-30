# sonn-core Beta

This beta app tracks the newest sonn-audio/core prerelease and runs the
published image `ghcr.io/sonn-audio/core:beta` with host networking.

## Persistent data

sonn-core stores its configuration (`config.json`, credentials, databases,
caches, library metadata, and other runtime state) under `/app/data`. This app
links `/app/data` to Home Assistant's private, persistent app data folder, so
it survives app restarts, rebuilds, and updates, and is included in app
backups by default.

This folder is private to the app (not exposed as a host-visible
configuration folder). To back up or migrate your sonn-core setup, use
sonn-core's own built-in backup/restore feature from its web interface, or a
full Home Assistant backup.

Note: sonn-core may internally update Node native dependencies such as
`@sonn-audio/node-libraop`. This requires the build toolchain to be present in
the addon image, which is included here so app-managed updates can complete
without failing during `node-gyp rebuild`.

Open the web interface at port **7090** after starting the app. The Loxone
protocols use ports **7091** and **7095** when enabled in sonn-core.

## Music library

Configure the music library from the sonn-core web interface. A local path
must be available to the app container. For an SMB or other network share,
mount it on the Home Assistant host first and then select the host path in
sonn-core. Mounting network shares from inside the app container requires
additional Linux capabilities and is not enabled by this app.

For complete setup instructions, see the
[sonn-core installation documentation](https://sonn-audio.github.io/docs/install/)
and [first setup guide](https://sonn-audio.github.io/docs/setup/).
