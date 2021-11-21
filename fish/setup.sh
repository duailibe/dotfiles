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

exit 0

for dir in "." "conf.d" functions completions; do
  if [ ! -e "$here/$dir" ]; then
    continue
  fi

  for file in "$here/$dir"/*; do
    if [ "$file" == "${BASH_SOURCE[0]}" ]; then
      continue
    fi
    filename=$(basename "$file")
    echo symlink "$file" "$fish/$dir/$filename"
  done
done
