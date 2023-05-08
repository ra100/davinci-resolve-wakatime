# DaVinci Resolve Wakatime

Tracks time spent on a project in a specific page (cut, edit, color, ...) to wakatime.com.

Supported:

- DaVinci Resolve on Linux
- Fusion Studio on Linux

## How to install

- install `wakatime-cli` - https://github.com/wakatime/wakatime-cli
- run `make all`

## Known issues

- if Resolve and Fusion run at the same time, Fusion heartbeat won't work as
  fuscript detects Fusion() from Resolve context
