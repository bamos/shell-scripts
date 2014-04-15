#!/bin/bash

if [ -s $HOME/.mutt/postponed ]; then
  notify-send 'mutt' 'Postponed messages\!'
fi
