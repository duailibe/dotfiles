set -x -g LC_ALL en_US.UTF-8
set -x -g LANG en_US.UTF-8
set -x -g EDITOR nvim

# Path configuration
set default_paths /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin
set homebrew_path
if test (uname -m) = "arm64"
  set homebrew_path /opt/homebrew/bin
end
set local_paths "$HOME/.dotfiles/bin" "$HOME/.local/bin"

# android tools
set android_path "$HOME/Library/Android/sdk/platform-tools" "$HOME/Library/Android/sdk/tools"

# Rust
set rust_path "$HOME/.cargo/bin"

set -gx PATH $local_paths $homebrew_path $default_paths $android_path $rust_path

# Homebrew installed
source (brew --prefix)/etc/grc.fish
source (brew --prefix asdf)/libexec/asdf.fish
