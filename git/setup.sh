#!/bin/sh

dotfiles="$HOME/.dotfiles"
source "$dotfiles/script/helpers.sh"

if ! [ -e "$HOME/.gitconfig.local" ]; then
  local name= email=

  info "Setting up local gitconfig"

  user "Type your name:"
  read name

  user "Type your e-mail:"
  read email

  git config -f "$HOME/.gitconfig.local" user.name "$name"
  git config -f "$HOME/.gitconfig.local" user.email "$email"

  success "Done"
fi

symlink "$dotfiles/git/gitconfig" "$HOME/.gitconfig"
symlink "$dotfiles/git/gitignore" "$HOME/.gitignore"
