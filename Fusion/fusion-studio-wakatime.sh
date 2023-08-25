#!/usr/bin/env bash

IDLE_TIME=$(xprintidle)

if [ "$IDLE_TIME" -gt 15000 ]; then
  exit 0;
fi

FUSION_ACTIVE=$(xdotool getwindowfocus getwindowname | grep "Visual")

if [ -n "$FUSION_ACTIVE" ]; then
  /opt/BlackmagicDesign/Fusion18/fuscript -l lua "$HOME/.local/bin/fusion-studio-wakatime.lua"
fi
