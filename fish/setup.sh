#!/bin/sh

dotfiles="$HOME/.dotfiles"
here="$dotfiles/fish"
fish="$HOME/.config/fish"

source "$dotfiles/script/helpers.sh"

if ! grep -q -F "$(brew --prefix)/bin/fish" /etc/shells; then
  _chsh() {
    echo "$(brew --prefix)/bin/fish" | sudo tee -a /etc/shells;
    chsh -s "$(brew --prefix)/bin/fish"
  }
  task "Set fish as default shell"
fi

find "$here" -type f -not -wholename "$here/setup.sh" | while read -r file; do
  dest="$fish/${file#"$here/"}"
  if [ ! -e "$(dirname "$dest")" ]; then
    mkdir -p "$(dirname "$dest")"
  fi
  symlink "$file" "$dest"
done

if ! fish -c "command -v fisher" &> /dev/null; then
  _fisher() {
    fish -c "curl -sL https://git.io/fisher | source && fisher update"
  }
  task "Installing fisher and fish plugins" _fisher
fi
