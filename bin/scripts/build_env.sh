#!/usr/bin/env bash

export SCRIPT_DIRECTORY="$(dirname "$(readlink -f "$0")")"
export ROOT_DIRECTORY="$(dirname "$(dirname "${SCRIPT_DIRECTORY}")")"

source "${SCRIPT_DIRECTORY}"/_lib.sh

if [[ "$@" == "--build" ]];then

  print_title "Build environment"
  
  if [ ! -f "${ROOT_DIRECTORY}"/.env ];then
    print_info "Environment file not found, create new one from env.example"
    [ ! -f "${ROOT_DIRECTORY}"/env.example ] && break_message "env.example file is missing in ${ROOT_DIRECTORY}"
    cp "${ROOT_DIRECTORY}"/env.example .env
    [ -f "${ROOT_DIRECTORY}"/.env ] && print_success "Environment file has been generate" || break_message "Fail to generate .env file"
  fi

  if [ ! -d ${ROOT_DIRECTORY}/src ];then
    print_info "Src directory not found, create one"
    mkdir ${ROOT_DIRECTORY}/src
    [ -d ${ROOT_DIRECTORY}/src ] && print_success "Src directory has been created" || break_message "Fail to create src directory"
  fi

  cd "${ROOT_DIRECTORY}"
  docker-compose up --build -d

elif [[ "$@" == "--purge" ]];then

  print_title "Purge environment"

  while true; do
    read -r -p "$(echo -e "${red}${bold}Warning : This command will reset all env, including src/ directory and remove all containers. Are you sure (n/y) ?${reset}")" RESPONSE
    if [[ "${RESPONSE}" == "n" || "${RESPONSE}" == "N" ]];then
      break_message "Abort project clean"
    elif [[ "${RESPONSE}" == "y" || "${RESPONSE}" == "Y" ]];then
      break;
    else
      continue
    fi
  done

  docker-compose down --rmi all --remove-orphans -v || break_message "Fail to purge containers"
  print_success "Containers delete with success"

  [ -f "${ROOT_DIRECTORY}"/.env ] && rm -f "${ROOT_DIRECTORY}"/.env || print_info "Env file not found"
  [ -d "${ROOT_DIRECTORY}"/src ]  && rm -rf "${ROOT_DIRECTORY}"/src || print_info "Directory src not found"
  if [[ -f "${ROOT_DIRECTORY}"/.env && -d "${ROOT_DIRECTORY}"/src ]];then
    break_message "Failed to delete files"
  fi
  print_success "Files delete with success"

fi
