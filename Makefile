export XDG_CONFIG_HOME = $(HOME)/.config

all: git

config-dir:
	mkdir -p "$(XDG_CONFIG_HOME)"

link-config: config-dir
	stow -t "$(XDG_CONFIG_HOME)" config

git-local:
	mkdir -p "$(XDG_CONFIG_HOME)/git"
	touch "$(XDG_CONFIG_HOME)/git/config.local"

git: git-local link-config github

github:
	@if ! gh auth status &> /dev/null; then \
		echo "Authenticating with GitHub.."; \
		gh auth login; \
	fi

brew:
	@command -v brew >/dev/null 2>&1 || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

