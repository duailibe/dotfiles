#!/bin/sh

dotfiles="$HOME/.dotfiles"
source "$dotfiles/script/helpers.sh"

if ! gh auth status &> /dev/null; then
  info "Authenticate with GitHub"
  echo

  gh auth login
fi

if ! [ -e "$HOME/.gitconfig.local" ]; then
  info "Setting up local gitconfig"

  user "Type your name:"
  read -r git_name

  user "Type your e-mail:"
  read -r git_email

  git config -f "$HOME/.gitconfig.local" user.name "$git_name"
  git config -f "$HOME/.gitconfig.local" user.email "$git_email"

  success "Done"
fi

symlink "$dotfiles/git/gitconfig" "$HOME/.gitconfig"
symlink "$dotfiles/git/gitignore" "$HOME/.gitignore"
