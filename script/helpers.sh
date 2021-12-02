# Helper functions

set -eo pipefail

info() {
  printf "\r[ \033[00;34m..\033[0m ] %s " "$1"
}

logcmd() {
  printf "\033[2m› %s\033[22m\n" "$1"
}

user() {
  printf "\r\033[2K[ \033[0;33m??\033[0m ] %s " "$1"
}

success() {
  printf "\r\033[2K[ \033[00;32mOK\033[0m ] %s\n" "$1"
}

fail() {
  printf "\r\033[2K[\033[0;31mFAIL\033[0m] %s\n" "$1"
  if [ -n "$2" ]; then
    printf "%s\n" "$2"
  fi
  exit 1
}

task() {
  info "$1"
  local output="" exit_code=0
  output=$($2 2>&1) || exit_code=$?
  if ! [ $exit_code -eq 0 ]; then
    fail "$1" "$output"
  else
    success "$1"
  fi
}

runcmd() {
  logcmd "$1"
  sh -c "$1"
}

symlink() {
  cyan() {
    printf "\033[00;36m%s\033[0m" "$1"
  }

  local src="$1" dst="$2"
  local action=""

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]; then

    if [ "$(readlink "$dst")" == "$src" ]; then
      return
    else

      user "File already exists: $dst. [S]kip, [o]verwrite or [backup]?"
      read -r -n 1 action
      echo

      case "$action" in
        s )
          success "skipped $src"
          return
          ;;

        o )
          rm -rf "$dst"
          success "removed $dst"
          ;;

        b )
          mv "$dst" "${dst}.backup"
          success "moved $dst to ${dst}.backup"
          ;;

        * )
          ;;
      esac

    fi

  fi

  ln -s "$1" "$2"
  success "linked $(cyan "$1") to $(cyan "$2")"
}

__in_sudo=false
enter_sudo() {
  if [ $__in_sudo == true ]; then
    return;
  fi

  sudo -n true 2> /dev/null || user "Entering sudo mode."
  sudo -v
  __in_sudo=true
  # Keep-alive: update existing `sudo` time stamp until `.macos` has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}
