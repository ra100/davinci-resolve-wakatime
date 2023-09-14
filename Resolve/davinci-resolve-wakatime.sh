#!/usr/bin/env bash

IDLE_TIME=$(xprintidle)

if [ "$IDLE_TIME" -gt 15000 ]; then
  exit 0;
fi

RESOLVE_ACTIVE=$(xdotool getwindowfocus getwindowname | grep "DaVinci Resolve")

if [ -n "$RESOLVE_ACTIVE" ]; then
  /opt/resolve/libs/Fusion/fuscript -l lua "$HOME/.local/bin/davinci-resolve-wakatime.lua"
fi
