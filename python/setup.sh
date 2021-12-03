#!/bin/sh

# shellcheck source=script/helpers.sh
source "$HOME/.dotfiles/script/helpers.sh"

asdf="$(brew --prefix asdf)/bin/asdf"

if ! "$asdf" which python &> /dev/null; then
  _install() {
    "$asdf" plugin add python
    "$asdf" install python latest
    "$asdf" global python latest
  }
  task "Installing Python" _install
fi

python="$("$asdf" which python)"
task "Upgrade pip" "$python -m pip install --upgrade pip"

for pkg in virtualenv pipx; do
  if ! "$python" -c "import $pkg" &> /dev/null; then
    task "Install $pkg" "$python -m pip install $pkg"
  fi
done
