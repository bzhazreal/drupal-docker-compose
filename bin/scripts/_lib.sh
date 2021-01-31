#!/usr/bin/env bash

###
#
# Fonts.
#
###
red="\e[0;91m"
blue="\e[0;94m"
green="\e[0;92m"

bold="\e[1m"
uline="\e[4m"

reset="\e[0m"

###
#
# Unicode
#
###
check="\u2713"
cross="\u26CC"
info="\u26A0"

###
#
# Message.
#
###
function print_success()
{
  printf "${green}${bold}${check}${reset} - %s \n" "$1"
}

function print_error()
{
  printf "${red}${bold}${cross}${reset} - %s \n" "$1"
}

function print_info()
{
  printf "${blue}${bold}${info}${reset} - %s \n" "$1"
}

function print_title() 
{
  printf "${blue}========== %s ==========${reset}\n" "${1}"
}

function break_message()
{
  print_error "${1}"
  exit 1
}

###
#
# File.
#
###

# Check directory content.
# Return 0 if empty or 1.
function directory_is_empty()
{
  if [ -z "$(ls -A $1)" ]; then
    return 0
  else
    return 1
  fi
}

###
#
# Interactions.
#
###

###
#
# Function to display a question and configure output.
#
###
function binary_question()
{

  while getopts :q:o:f option; do
    case "${option}" in
        q) QUESTION=${OPTARG};;
        o) ANSWER_TRUE=${OPTARG};;
        f) ANSWER_FALSE=${OPTARG};;
    esac
  done

  if [ -z "${QUESTION}" ]  || [ -z "${ANSWER_TRUE}" ] || [ -z "${ANSWER_FALSE}" ];then
    break_message "Missing argument."
  fi

  while true; do
    read -r -p "$(echo -e "${red}${bold}Warning : ${QUESTION}. Are you sure (n/y) ?${reset}")" RESPONSE
    if [[ "${RESPONSE}" == "n" || "${RESPONSE}" == "N" ]];then
      return 1
    elif [[ "${RESPONSE}" == "y" || "${RESPONSE}" == "Y" ]];then
      return 0
    else
      continue
    fi
  done

}