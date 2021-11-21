#!/bin/sh

dotfiles="$HOME/.dotfiles"
here="$dotfiles/fish"
fish="$HOME/.config/fish"

source "$dotfiles/script/helpers.sh"

symlink "$here/config.fish" "$fish/config.fish"

for dir in "conf.d" functions completions; do
  if [ -e "$here/$dir" ]; then
    for file in $(ls "$here/$dir"); do
      symlink "$here/$dir/$file" "$fish/$dir/$file"
    done
  fi
done
