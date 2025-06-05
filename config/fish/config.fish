set -x -g LC_ALL en_US.UTF-8
set -x -g LANG en_US.UTF-8
set -x -g EDITOR nvim

if test -e /opt/homebrew/bin/brew
  /opt/homebrew/bin/brew shellenv | source
  source (brew --prefix)/etc/grc.fish
  set HOMEBREW_NO_AUTO_UPDATE 1
end 

fish_add_path ~/.dotfiles/bin

if command -q "mise"
  mise activate fish | source
end

if command -q "starship"
  starship init fish | source
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
