#!/bin/bash
#
# sync.sh
# Sync a directory *to* remote machines.
#
# Brandon Amos <http://bamos.github.io>
# 2013.07.17

REMOTE_DIR='~'

function sync {
  local REMOTE_SERVER=$1
  [[ $# == 2 ]] && local REMOTE_USER=$2@
  rsync -a --delete $SCRIPT_DIR/ \
    $REMOTE_USER$REMOTE_SERVER:$REMOTE_DIR/$SCRIPT_DIR \
    &> $SCRIPT_DIR/logs/transfer-$REMOTE_SERVER.log
  if [[ $? == 0 ]]; then
    echo "Sync to '$REMOTE_SERVER' success."
  else
    echo "Transfer to '$REMOTE_SERVER' failure. \
     See '$SCRIPT_DIR/logs/transfer-$REMOTE_SERVER.log'."
    return
  fi
  # Add any further processing here, such as changing permissions.
}

cd $(dirname $0)
# Add any directory cleanups here, such as `make clean`.
SCRIPT_DIR=${PWD##*/}
cd ..

rm -rf $SCRIPT_DIR/logs
mkdir -p $SCRIPT_DIR/logs

sync server1
sync server2 username
