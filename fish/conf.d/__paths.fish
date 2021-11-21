set default_paths /usr/bin /usr/sbin /bin /sbin
set homebrew_paths /usr/local/bin /usr/local/sbin
set local_paths "$HOME/.dotfiles/bin" "$HOME/.local/bin"

# android tools
set android_path "$HOME/Library/Android/sdk/tools"

set -gx PATH $local_paths $homebrew_paths $default_paths $android_path
