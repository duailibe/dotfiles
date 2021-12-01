set -x -g LC_ALL en_US.UTF-8
set -x -g LANG en_US.UTF-8
set -x -g EDITOR vim

# Path configuration
set default_paths /usr/bin /usr/sbin /bin /sbin
set homebrew_paths /usr/local/bin /usr/local/sbin
set local_paths "$HOME/.dotfiles/bin" "$HOME/.local/bin"

# android tools
set android_path "$HOME/Library/Android/sdk/tools"

set -gx PATH $local_paths $homebrew_paths $default_paths $android_path

# Homebrew installed
source (brew --prefix)/etc/grc.fish
source (brew --prefix asdf)/libexec/asdf.fish
