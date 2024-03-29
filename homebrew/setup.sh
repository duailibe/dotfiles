#!/bin/sh

dotfiles="$HOME/.dotfiles"
here="$dotfiles/homebrew"
# shellcheck source=script/helpers.sh
source "$dotfiles/script/helpers.sh"

if ! command -v brew &> /dev/null; then
  enter_sudo
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
