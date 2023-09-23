#! /usr/bin/env bash

wl-copy --clear

CONTENT=$(wl-paste)

[[ -z $CONTENT ]] && notify-send --app-name="Clipboard Clearer" --icon info --urgency normal "Clipboard Clearer" "Clipboard is Empty" || notify-send --app-name="Clipboard Clearer" --icon info --urgency normal "Clipboard Clearer" "Clipboard Content: $CONTENT"
