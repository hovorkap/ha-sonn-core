# sonn-core Beta

This beta app tracks the newest sonn-audio/core prerelease and runs the
published image `ghcr.io/sonn-audio/core:beta` with host networking.

## Persistent files

A single Home Assistant app configuration folder is mapped into the container
at `/config`. On startup, the app splits this into two subdirectories:

- `/config/data` — sonn-core's `config.json`, credentials, databases, caches,
  library metadata, and other runtime state.
- `/config/public` — sonn-core's admin UI and player web bundles, so UI
  updates made from sonn-core survive an app image update.

Inside the container, `/app/data` and `/app/public` are symlinks that point to
these two folders. Both live under the same mapped host folder, but are kept
in their own subdirectories so their contents never mix.

Stop the app before editing `config.json` under `data/` manually, because the
running admin panel can overwrite it.

Note: earlier versions of this app mapped the same host folder directly at
both `/app/data` and `/app/public`, which merged their contents together in
one shared directory. The first time this version starts, it automatically
splits any existing merged content into the new `data/` and `public/`
subdirectories, so existing installations are migrated without data loss.

Note: sonn-core may internally update Node native dependencies such as
`@sonn-audio/node-libraop`. This requires the build toolchain to be present in
the addon image, which is included here so app-managed updates can complete
without failing during `node-gyp rebuild`.

Open the web interface at port **7090** after starting the app. The Loxone
protocols use ports **7091** and **7095** when enabled in sonn-core.

## Persistent data

The app configuration, library metadata, logs, and cache are stored in the
Home Assistant app configuration directory, under `data/`, and mounted into
sonn-core as `/app/data`. Back up the whole configuration folder to back up
the sonn-core installation.

## Music library

Configure the music library from the sonn-core web interface. A local path
must be available to the app container. For an SMB or other network share,
mount it on the Home Assistant host first and then select the host path in
sonn-core. Mounting network shares from inside the app container requires
additional Linux capabilities and is not enabled by this app.

For complete setup instructions, see the
[sonn-core installation documentation](https://sonn-audio.github.io/docs/install/)
and [first setup guide](https://sonn-audio.github.io/docs/setup/).
