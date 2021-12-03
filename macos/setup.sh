#!/bin/sh
# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.

dotfiles="$HOME/.dotfiles"
# shellcheck source=script/helpers.sh
source "$dotfiles/script/helpers.sh"

theme="$(defaults read com.apple.Terminal "Default Window Settings")"
if [ ! "$theme" == "Snazzy" ]; then
  _theme() {
    osascript "$dotfiles/macos/set-terminal-theme.applescript"
  }
  task "Install Terminal theme" _theme
fi

enter_sudo

info "Update macOS software"
echo
runcmd "sudo softwareupdate -i -a"

if mas account &> /dev/null; then
  runcmd "mas upgrade"
fi
