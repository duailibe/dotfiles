DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := /opt/homebrew/bin:$(PATH)
UNAME := $(shell uname)
export XDG_CONFIG_HOME = $(HOME)/.config

ifeq ($(shell uname), Darwin)
	OS := macos
else
	OS := ubuntu
endif

all: $(OS)

macos: brew-packages git dock

ubuntu: mise-linux git stow

config-dir:
	mkdir -p "$(XDG_CONFIG_HOME)"

stow: config-dir
	stow -t "$(XDG_CONFIG_HOME)" --no-folding config

git-local:
	@mkdir -p "$(XDG_CONFIG_HOME)/git"
ifeq ($(wildcard $(XDG_CONFIG_HOME)/git/config.local),)
	@echo "# [user]\n# \temail = the-email\n\n# # example for separate info for specific dirs/repos:\n# [includeIf \"gitdir:path/to/repo\"]\n# \temail = work-email\n# " > $(XDG_CONFIG_HOME)/git/config.local
endif

git: git-local stow github

github:
	@if ! gh auth status &> /dev/null; then \
		echo "Authenticating with GitHub.."; \
		gh auth login; \
	fi

brew:
	@command -v brew >/dev/null 2>&1 || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

brew-packages: brew
	brew bundle --file="$(DOTFILES_DIR)/Brewfile"

mise-linux:
	curl https://mise.run | sh

dock:
	@dockutil --no-restart --remove all
	@dockutil --no-restart --add "/Applications/Google Chrome.app"
	@dockutil --no-restart --add "/Applications/Ghostty.app"
	@dockutil --no-restart --add "/Applications/Slack.app"
	@dockutil --no-restart --add "/Applications" -s others
	@killall Dock
