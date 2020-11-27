#!/usr/bin/env bash

export SCRIPT_DIRECTORY="$(dirname "$(readlink -f "$0")")"
export ROOT_DIRECTORY="$(dirname "$(dirname "${SCRIPT_DIRECTORY}")")"

source "${SCRIPT_DIRECTORY}"/_lib.sh

###
#
# Env file check
# - Ignore if env file already exist.
# - Create env file from env.example if not exist
#
###
if [ ! -f "${ROOT_DIRECTORY}"/.env ];then
  
  print_info "Environment file not found, create new one from env.example"
  
  if [ ! -f "${ROOT_DIRECTORY}"/env.example ];then
    print_error "env.example file is missing in ${ROOT_DIRECTORY}"  
  fi

  cp "${ROOT_DIRECTORY}"/env.example .env

  if [ -f "${ROOT_DIRECTORY}"/.env ];then
    print_success "Environment file has been generate"
  else
    print_error "Fail to generate .env file"
  fi

fi

###
#
# Execute docker-compose
#
###
cd "${ROOT_DIRECTORY}"
docker-compose up --build -d