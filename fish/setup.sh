#!/bin/sh

dotfiles="$HOME/.dotfiles"
here="$dotfiles/fish"
fish="$HOME/.config/fish"

source "$dotfiles/script/helpers.sh"

cd "$here"

for file in $(find * -type f -not -wholename "setup.sh"); do
  dir=$(dirname "$file")
  if [ ! -e "$fish/$dir" ]; then
    mkdir -p "$fish/$dir"
  fi
  symlink "$here/$file" "$fish/$file"
done
