#!/bin/bash

notify-send "Quick Key 8: Open Spotify";

google-chrome \
  --profile-directory="Default" \
  --app="https://player.spotify.com/"
