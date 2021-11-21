#!/bin/sh

dotfiles="$HOME/.dotfiles"
here="$dotfiles/homebrew"
source "$dotfiles/script/helpers.sh"

if ! which brew &> /dev/null; then
  info "Installing Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  success "Done"
fi

cd $here

_task() {
  brew update
  brew bundle --no-lock
  brew upgrade
  brew cleanup
}

task "Installing/upgrading Homebrew packages" _task
