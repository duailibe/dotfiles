#!/bin/sh

dotfiles="$HOME/.dotfiles"
here="$dotfiles/homebrew"
source "$dotfiles/script/helpers.sh"

if ! which brew &> /dev/null; then
  info "Installing Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  success "Done"
fi

_task() {
  runcmd "brew update"
  runcmd "brew bundle --no-lock --file $here/Brewfile"
  runcmd "brew upgrade"
  runcmd "brew cleanup"
}

task "Installing/upgrading Homebrew packages" _task
