# sonn-core Canary

This canary app runs the published
`ghcr.io/sonn-audio/core:4.0.0-beta.19` image with host networking. Host
networking is required for reliable discovery of Sonos, Chromecast, AirPlay,
and DLNA devices.

## Persistent files

The app configuration directory is mapped to sonn-core's `/app/data` directory.
This includes `config.json`, credentials, databases, caches, library metadata,
and other runtime state. It is available under the app's configuration folder
on the Home Assistant host and can be edited manually. Stop the app before
editing `config.json`, because the running admin panel can overwrite it.

The complete `/app/public` directory is mapped to the app configuration folder.
This preserves updates made from sonn-core's admin panel when Home Assistant
recreates the container during an app update. On first startup, the bundled
admin UI and player files are copied into that directory automatically.

Open the web interface at port **7090** after starting the app. The Loxone
protocols use ports **7091** and **7095** when enabled in sonn-core.

## Persistent data

The app configuration, library metadata, logs, and cache are stored in the
Home Assistant app configuration directory and mounted into sonn-core as
`/app/data`. Back up this directory to back up the sonn-core installation.

## Music library

Configure the music library from the sonn-core web interface. A local path
must be available to the app container. For an SMB or other network share,
mount it on the Home Assistant host first and then select the host path in
sonn-core. Mounting network shares from inside the app container requires
additional Linux capabilities and is not enabled by this app.

For complete setup instructions, see the
[sonn-core installation documentation](https://sonn-audio.github.io/docs/install/)
and [first setup guide](https://sonn-audio.github.io/docs/setup/).
