#!/bin/sh

dotfiles="$HOME/.dotfiles"
source "$dotfiles/script/helpers.sh"

if ! brew list asdf &> /dev/null; then
  _task() {
    brew install asdf
  }
  task "Installing asdf" _task
fi

asdf="$(brew --prefix asdf)/bin/asdf"
plugins="$("$asdf" plugin list)"

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
