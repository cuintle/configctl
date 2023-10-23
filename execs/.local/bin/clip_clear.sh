#! /usr/bin/env bash

CONTENT=$(wl-paste --primary)

wl-copy --clear --primary

[[ -z $CONTENT ]] && notify-send --app-name="Clipboard Clearer" --icon info --urgency normal "Clipboard Clearer" "Clipboard is Empty" || notify-send --app-name="Clipboard Clearer" --icon info --urgency normal "Clipboard Clearer" "Clipboard Content was: $CONTENT, but it is now clear"
