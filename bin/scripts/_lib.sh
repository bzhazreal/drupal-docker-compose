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