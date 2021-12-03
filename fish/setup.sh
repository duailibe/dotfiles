#!/bin/sh

dotfiles="$HOME/.dotfiles"
here="$dotfiles/fish"
fish="$HOME/.config/fish"

source "$dotfiles/script/helpers.sh"

find "$here" -type f -not -wholename "$here/setup.sh" | while read -r file; do
  dest="$fish/${file#"$here/"}"
  if [ ! -e "$(dirname "$dest")" ]; then
    mkdir -p "$(dirname "$dest")"
  fi
  symlink "$file" "$dest"
done
