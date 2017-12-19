#!/bin/bash

notify-send "Quick Key 1: Set Up Chrome";

google-chrome \
  --new-window \
  --profile-directory="Default" \
  https://inbox.google.com/ \
  https://octobox.io/ \
  https://tweetdeck.twitter.com/ \
  chromiumdev.slack.com

google-chrome \
  --new-window \
  --profile-directory="Profile 2" \
  https://inbox.google.com/ \
  https://calendar.google.com/
