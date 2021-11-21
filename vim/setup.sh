#!/bin/sh

dotfiles="$HOME/.dotfiles"
source "$dotfiles/script/helpers.sh"

symlink "$dotfiles/vim/vimrc" "$HOME/.vimrc"
