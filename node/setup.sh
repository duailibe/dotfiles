#!/bin/sh

source "$HOME/.dotfiles/script/helpers.sh"

asdf="$(brew --prefix asdf)/bin/asdf"

if ! "$asdf" which node &> /dev/null; then
  _install() {
    "$asdf" plugin add nodejs
    "$asdf" install nodejs latest
    "$asdf" global nodejs latest
  }
  task "Installing nodejs"
fi
