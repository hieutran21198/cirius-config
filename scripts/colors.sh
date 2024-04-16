#!/usr/bin/env bash

# Regular Colors
Black='\e[0;30m'
Red='\e[0;31m'
Green='\e[0;32m'
Brown_Orange='\e[0;33m'
Blue='\e[0;34m'
Purple='\e[0;35m'
Cyan='\e[0;36m'
Light_Gray='\e[0;37m'

# Bold Colors
Dark_Gray='\e[1;30m'
Light_Red='\e[1;31m'
Light_Green='\e[1;32m'
Yellow='\e[1;33m'
Light_Blue='\e[1;34m'
Light_Purple='\e[1;35m'
Light_Cyan='\e[1;36m'
White='\e[1;37m'

# Reset
Color_Off='\e[0m'

color_msg () {
  local message="$1"
  local color="$2"
  echo -e "${color}${message}${Color_Off}"
}
