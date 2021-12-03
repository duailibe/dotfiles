#!/bin/sh

dotfiles="$HOME/.dotfiles"
# shellcheck source=script/helpers.sh
source "$dotfiles/script/helpers.sh"

symlink "$dotfiles/vim/vimrc" "$HOME/.vimrc"
