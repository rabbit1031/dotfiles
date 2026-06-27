DOTFILES_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
PLATFORM     := $(shell uname -s)
FORCE        ?=
LN_FLAGS     := -sv$(if $(FORCE),f)

.PHONY: all link link-force link-bash link-zsh link-nvim link-starship link-git link-gemini link-claude link-npm link-ghostty help

all: link-bash link-zsh link-nvim link-starship link-git link-gemini link-claude link-npm link-ghostty

link: all

link-force:
	$(MAKE) all FORCE=1

# Safely link a directory: remove existing symlink, backup real dir, then link.
# Usage: $(call SAFE_LINK_DIR,src,dest)
define SAFE_LINK_DIR
@if [ -L "$(2)" ]; then \
	rm -f "$(2)"; \
elif [ -d "$(2)" ]; then \
	echo "Warning: $(2) is an existing standard directory. Backing it up to $(2).bak"; \
	mv "$(2)" "$(2).bak"; \
elif [ -e "$(2)" ]; then \
	rm -f "$(2)"; \
fi
@ln -svn "$(1)" "$(2)"
endef

link-bash:
	ln $(LN_FLAGS) $(DOTFILES_DIR)/bash/.bash_profile $(HOME)/.bash_profile
	ln $(LN_FLAGS) $(DOTFILES_DIR)/bash/.bashrc $(HOME)/.bashrc

link-zsh:
	ln $(LN_FLAGS) $(DOTFILES_DIR)/zsh/.zshrc $(HOME)/.zshrc
	@if [ -r "$(DOTFILES_DIR)/zsh/.zshrc.$(PLATFORM)" ]; then \
		ln $(LN_FLAGS) "$(DOTFILES_DIR)/zsh/.zshrc.$(PLATFORM)" "$(HOME)/.zshrc.$(PLATFORM)"; \
	fi

link-nvim:
	@mkdir -pv $(HOME)/.config
	$(call SAFE_LINK_DIR,$(DOTFILES_DIR)/nvim,$(HOME)/.config/nvim)

link-starship:
	@mkdir -pv $(HOME)/.config
	ln $(LN_FLAGS) $(DOTFILES_DIR)/starship.toml $(HOME)/.config/starship.toml

link-git:
	ln $(LN_FLAGS) $(DOTFILES_DIR)/git/.gitconfig $(HOME)/.gitconfig
	ln $(LN_FLAGS) $(DOTFILES_DIR)/git/.gitignore_global $(HOME)/.gitignore_global

link-gemini:
	@mkdir -pv $(HOME)/.gemini
	ln $(LN_FLAGS) $(DOTFILES_DIR)/agents/gemini/settings.json $(HOME)/.gemini/settings.json
	ln $(LN_FLAGS) $(DOTFILES_DIR)/agents/AGENTS.md $(HOME)/.gemini/GEMINI.md
	$(call SAFE_LINK_DIR,$(DOTFILES_DIR)/agents/gemini/policies,$(HOME)/.gemini/policies)

link-claude:
	@mkdir -pv $(HOME)/.claude
	ln $(LN_FLAGS) $(DOTFILES_DIR)/agents/AGENTS.md $(HOME)/.claude/CLAUDE.md
	ln $(LN_FLAGS) $(DOTFILES_DIR)/agents/claude/settings.json $(HOME)/.claude/settings.json
	@mkdir -pv $(HOME)/.config/ccstatusline
	ln $(LN_FLAGS) $(DOTFILES_DIR)/agents/claude/ccstatusline-settings.json $(HOME)/.config/ccstatusline/settings.json
	$(call SAFE_LINK_DIR,$(DOTFILES_DIR)/agents/claude/plugins/notion-workflow/skills,$(HOME)/.claude/skills)

link-npm:
	ln $(LN_FLAGS) $(DOTFILES_DIR)/.npmrc $(HOME)/.npmrc

link-ghostty:
	@mkdir -pv $(HOME)/.config/ghostty
	ln $(LN_FLAGS) $(DOTFILES_DIR)/config.ghostty $(HOME)/.config/ghostty/config.ghostty

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  link          Link all dotfiles (safe)"
	@echo "  link-force    Link all dotfiles (force overwrite)"
	@echo "  link-bash     Link bash config"
	@echo "  link-zsh      Link zsh config"
	@echo "  link-nvim     Link Neovim config"
	@echo "  link-starship Link Starship config"
	@echo "  link-git      Link Git config"
	@echo "  link-gemini   Link Gemini agent config"
	@echo "  link-claude   Link Claude agent config"
	@echo "  link-npm      Link npm config"
	@echo "  link-ghostty  Link Ghostty config"
