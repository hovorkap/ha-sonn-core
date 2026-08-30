# Changelog

## 4.0.0-beta.20-r1

- Fix "Permission denied" errors at startup when linking `/app/data`: our own
  AppArmor profile was missing the `dac_override`/`dac_read_search`
  capabilities root needs to modify files owned by the `node` user inside
  the image (e.g. `/app/public`, `/app/data`). Added the missing
  capabilities.
- Add timestamps to app logs.

## 4.0.0-beta.20

- Track the sonn-audio/core 4.0.0-beta.20 release.
- Simplify persistence: drop the `addon_config` folder mapping and the
  data/public split entirely. `/app/data` is now linked to Home Assistant's
  private, per-app `/data` folder, which is automatically persistent across
  restarts, rebuilds, and updates, and included in app backups.
- `/app/public` is no longer persisted across updates; it always comes from
  the image. Use sonn-core's built-in backup/restore feature for anything you
  need to carry across updates.
- **Upgrade note:** this changes where configuration is stored. Back up your
  configuration using sonn-core's web UI backup/restore feature before
  updating from an earlier version, then restore it after the app has
  restarted with the new version if it does not start pre-configured.

## 4.0.0-beta.19-r2

- Fix startup crash "failed to preserve ownership" seeding `/config`: the
  bind-mounted app configuration folder does not support `chown`, so the
  first-run seeding of `data/`/`public/` now copies files without trying to
  preserve ownership.

## 4.0.0-beta.19-r1

- Fix configuration loss on restart/rebuild: the app previously mapped the
  same host folder at both `/app/data` and `/app/public`, which merged their
  contents and could wipe or corrupt data when Home Assistant recreated the
  container. Now a single `/config` folder is mapped and split into
  `data/` and `public/` subdirectories (via symlinks), with automatic
  one-time migration of any existing merged content.

## 4.0.0-beta.19

- Track the beta sonn-audio/core 4.0.0-beta.19 release.
