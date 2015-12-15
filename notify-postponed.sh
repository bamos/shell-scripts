#!/bin/bash

set -e -u

if [ -s $HOME/.mutt/postponed ]; then
  case $(uname) in
    "Linux")
      notify-send 'mutt' 'Postponed messages\!'
    ;;
    "Darwin")
      /usr/local/bin/terminal-notifier \
        -title 'mutt' -message 'Postponed messages!' -group 'mutt-postponed'
    ;;
  esac
fi
