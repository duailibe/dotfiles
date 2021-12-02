#!/bin/sh

dotfiles="$HOME/.dotfiles"
here="$dotfiles/homebrew"
source "$dotfiles/script/helpers.sh"

if ! which brew &> /dev/null; then
  _task() {
    printf "\n" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  }
  task "Installing Homebrew" _task
fi

_task() {
  runcmd "brew update"
  runcmd "brew bundle --no-lock --no-upgrade --file $here/Brewfile"
  runcmd "brew upgrade"
  runcmd "brew cleanup"
}

task "Installing/upgrading Homebrew packages" _task
