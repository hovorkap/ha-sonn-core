# sonn-audio Home Assistant app repository

This repository provides a Home Assistant app that runs
[sonn-core](https://sonn-audio.github.io/docs/) (Loxone Music Server
emulation).

The stable app tracks sonn-audio/core **3.1.0**.
The canary app tracks sonn-audio/core **4.0.0-beta.19**.

![sonn-core icon](sonn-core/icon.png)

## Installation

1. In Home Assistant, open **Settings → Apps → App store**.
2. Open the menu in the top-right and choose **Repositories**.
3. Add this repository URL:
   `https://github.com/hovorkap/ha-sonn-core`
4. Install **sonn-core** from the repository.

The repository publishes both a stable **sonn-core** app and a canary
**sonn-core Canary** app. The canary app uses a separate configuration folder
because it has a separate Home Assistant app slug.

Each app persists sonn-core's configuration and data under its own Home
Assistant app configuration folder, including `config.json`. Its admin UI and
player bundles are persisted there as well, so UI updates made from sonn-core
survive an app image update.

The app uses host networking because sonn-core discovers Sonos, Chromecast,
AirPlay, and DLNA devices on the local network.

See the [sonn-core installation documentation](https://sonn-audio.github.io/docs/install/)
for service configuration and the supported protocols.

## Credits and licensing

This app is a Home Assistant wrapper around the
[sonn-audio/core](https://github.com/sonn-audio/core) project by Rudy Berends
and contributors. Their original work and container image retain their own
license and attribution notices; see [`NOTICE`](NOTICE) and the
[upstream license](https://github.com/sonn-audio/core/blob/main/LICENSE).

The wrapper files in this repository are licensed under the Apache License
2.0.
