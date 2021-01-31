#!/usr/bin/env bash

export SCRIPT_DIRECTORY="$(dirname "$(readlink -f "$0")")"
export ROOT_DIRECTORY="$(dirname "$(dirname "${SCRIPT_DIRECTORY}")")"

source "${SCRIPT_DIRECTORY}"/_lib.sh

if [[ "$@" == "--install" ]];then
  print_title "Install drupal"
  if [ $(directory_is_empty "${ROOT_DIRECTORY}/src") ];then
    echo "directory empty"
  else
    echo 'pas empty'
  fi
else
  break_message "Command not found"
fi
