DOTFILES_DIR := $(shell pwd)
PLATFORM     := $(shell uname -s)
FORCE        ?=
LN_FLAGS     := -sv$(if $(FORCE),f)

.PHONY: all bash zsh nvim starship git gemini claude npm ghostty

all: bash zsh nvim starship git gemini claude npm ghostty

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

bash:
	ln $(LN_FLAGS) $(DOTFILES_DIR)/bash/.bash_profile $(HOME)/.bash_profile
	ln $(LN_FLAGS) $(DOTFILES_DIR)/bash/.bashrc $(HOME)/.bashrc

zsh:
	ln $(LN_FLAGS) $(DOTFILES_DIR)/zsh/.zshrc $(HOME)/.zshrc
	@if [ -r "$(DOTFILES_DIR)/zsh/.zshrc.$(PLATFORM)" ]; then \
		ln $(LN_FLAGS) "$(DOTFILES_DIR)/zsh/.zshrc.$(PLATFORM)" "$(HOME)/.zshrc.$(PLATFORM)"; \
	fi

nvim:
	@mkdir -pv $(HOME)/.config
	$(call SAFE_LINK_DIR,$(DOTFILES_DIR)/nvim,$(HOME)/.config/nvim)

starship:
	@mkdir -pv $(HOME)/.config
	ln $(LN_FLAGS) $(DOTFILES_DIR)/starship.toml $(HOME)/.config/starship.toml

git:
	ln $(LN_FLAGS) $(DOTFILES_DIR)/git/.gitconfig $(HOME)/.gitconfig
	ln $(LN_FLAGS) $(DOTFILES_DIR)/git/.gitignore_global $(HOME)/.gitignore_global

gemini:
	@mkdir -pv $(HOME)/.gemini
	ln $(LN_FLAGS) $(DOTFILES_DIR)/agents/gemini/settings.json $(HOME)/.gemini/settings.json
	ln $(LN_FLAGS) $(DOTFILES_DIR)/agents/AGENTS.md $(HOME)/.gemini/GEMINI.md
	$(call SAFE_LINK_DIR,$(DOTFILES_DIR)/agents/gemini/policies,$(HOME)/.gemini/policies)

claude:
	@mkdir -pv $(HOME)/.claude
	ln $(LN_FLAGS) $(DOTFILES_DIR)/agents/AGENTS.md $(HOME)/.claude/CLAUDE.md
	ln $(LN_FLAGS) $(DOTFILES_DIR)/agents/claude/settings.json $(HOME)/.claude/settings.json
	@mkdir -pv $(HOME)/.config/ccstatusline
	ln $(LN_FLAGS) $(DOTFILES_DIR)/agents/claude/ccstatusline-settings.json $(HOME)/.config/ccstatusline/settings.json
	$(call SAFE_LINK_DIR,$(DOTFILES_DIR)/agents/claude/commands,$(HOME)/.claude/commands)
	$(call SAFE_LINK_DIR,$(DOTFILES_DIR)/agents/claude/plugins/notion-workflow/skills,$(HOME)/.claude/skills)

npm:
	ln $(LN_FLAGS) $(DOTFILES_DIR)/.npmrc $(HOME)/.npmrc

ghostty:
	@mkdir -pv $(HOME)/.config/ghostty
	ln $(LN_FLAGS) $(DOTFILES_DIR)/config.ghostty $(HOME)/.config/ghostty/config.ghostty
