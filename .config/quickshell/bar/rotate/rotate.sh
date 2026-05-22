#!/bin/bash

DISPLAY="eDP-1"
TOUCH="1267:10780:ELAN9038:00_04F3:2A1C"
CURRENT=$(swaymsg -t get_outputs | jq -r '.[] | select(.name == "eDP-1") | .transform')

if [ "$CURRENT" = "normal" ]; then
  swaymsg output "$DISPLAY" transform 270
else
  swaymsg output "$DISPLAY" transform 0
fi
