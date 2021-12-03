#!/bin/sh

dotfiles="$HOME/.dotfiles"
source "$dotfiles/script/helpers.sh"

asdf="$(brew --prefix asdf)/bin/asdf"
plugins="$("$asdf" plugin list 2>/dev/null || :;)"

for plugin in python nodejs; do
  if ! [[ $plugins =~ $plugin ]]; then
    _task() {
      "$asdf" plugin add "$plugin"
      "$asdf" install "$plugin" latest
      "$asdf" global "$plugin" latest
    }
    task "Installing $plugin" _task
  fi
done
