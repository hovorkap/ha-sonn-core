# sonn-audio Home Assistant app repository

This repository provides Home Assistant apps that run
[sonn-core](https://sonn-audio.github.io/docs/) (Loxone Music Server
emulation).

The repository publishes three app channels:

- **Latest** tracks the current stable sonn-core release and uses the upstream
  `latest` image tag, falling back to `latest-beta` if needed.
- **Beta** tracks the newest prerelease and uses the upstream `beta-latest`
  image tag.
- **Canary** tracks the newest prerelease track and uses the upstream
  `dev-latest` image tag.

Current app versions in this repository:

- Latest app: **3.1.0**
- Beta app: **4.0.0-beta.19**
- Canary app: **4.0.0-beta.19**

![sonn-core icon](sonn-core/icon.png)

## Installation

1. In Home Assistant, open **Settings → Apps → App store**.
2. Open the menu in the top-right and choose **Repositories**.
3. Add this repository URL:
   `https://github.com/hovorkap/ha-sonn-core`
4. Install one of the app entries from the repository: **sonn-core Latest**,
   **sonn-core Beta**, or **sonn-core Canary**.

Each app uses its own Home Assistant app configuration folder and its own
`/app/data` and `/app/public` persistence area. This keeps each channel's
configuration, cache, and UI bundle separate.

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
