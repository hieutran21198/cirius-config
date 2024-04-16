#!/usr/bin/env bash
if [ "$#" -lt 1 ]; then
  echo "Usage: install-tools.sh tool"
fi

source ./scripts/colors.sh

is_installed () {
  if [ "$#" -ne 1 ]; then
    echo "Usage: is_installed <pkg> [<msg_prefix>]"
    return 1
  fi
  
  local pkg=$1
  local msg_prefix=$2
  if ! command -v "$pkg" &> /dev/null; then
    printf "${msg_prefix}'$pkg': $(color_msg "not installed" "$Red")\n"
    return 1
  else
    printf "${msg_prefix}'$pkg': $(color_msg "installed" "$Green")\n"
    return 0
  fi
}

check_deps () {
  if [ "$#" -lt 2 ]; then
    echo "Usage: check_deps <dep_of> <dep1> [<dep2> ...]"
    return 1
  fi

  local dep_of=$1
  shift # remove the first argument
  printf "Checking dependencies for '$(color_msg "$dep_of" "$Green")'...\n"
  local satisfied=true
  for pkg in "$@"; do
    if ! is_installed "$pkg"; then
      satisfied=false
    fi
  done

  if [ "$satisfied" = false ]; then
    echo "Please install the required packages and try again."
    return 1
  fi

  printf "All dependencies for '$(color_msg "$dep_of" "$Green")' are satisfied.\n"
  return 0
}

backup_and_link () {
  if [ "$#" -ne 2 ]; then
    echo "Usage: backup_and_link <src> <dest>"
    return 1
  fi

  local src=$1
  local dest=$2

  if [ -L "$dest" ]; then
    printf "Removing old link '$dest'...\n"
    rm "$dest"
  elif [ -f "$dest" ] || [ -d "$dest" ]; then
    printf "Backing up '$dest'...\n"
    mv "$dest" "${dest}_bak_$(date +"%Y%m%d%H%M%S")"
  fi

  echo "Linking '$src' to '$dest'..."
  ln -s "$src" "$dest"

  return 0
}

# check if args are passed
if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    exit 1
fi

tool=$1

# wezterm
if test "$tool" = "wezterm"; then
  if ! is_installed "$tool"; then
    echo "TODO: $tool installation is not supported yet."
    echo "Please install $tool manually."
    exit 1
  fi

  echo "Configuring \"$tool\"..."
  backup_and_link "$PWD/config/wezterm" "$HOME/.config/wezterm"
  echo "Done."
fi


if test "$tool" = "nvim"; then
  if ! is_installed "$tool"; then
    echo "TODO: $tool installation is not supported yet."
    echo "Please install $tool manually."
    exit 1
  fi

  echo "Configuring \"$tool\"..."
  backup_and_link "$PWD/config/nvim" "$HOME/.config/nvim"
  echo "Done."
fi
