# Changelog

## 4.0.0-beta.19-r1

- Fix configuration loss on restart/rebuild: the app previously mapped the
  same host folder at both `/app/data` and `/app/public`, which merged their
  contents and could wipe or corrupt data when Home Assistant recreated the
  container. Now a single `/config` folder is mapped and split into
  `data/` and `public/` subdirectories (via symlinks), with automatic
  one-time migration of any existing merged content.

## 4.0.0-beta.19

- Track the beta sonn-audio/core 4.0.0-beta.19 release.
