# dotfiles

Personal configuration files for macOS.

## Install the applications

Install WezTerm, Starship, Neovim, direnv, git-delta, Tree-sitter CLI, and ripgrep with Homebrew:

```sh
brew bundle --file ~/dotfiles/Brewfile
```

## Included

- `.zshrc` — Zsh configuration
- `.config/wezterm/wezterm.lua` — WezTerm settings and key bindings
- `.config/starship.toml` — Starship prompt
- `.config/nvim/` — Neovim Lua settings, plugin manager, theme, file explorer, fuzzy finder, LSP, completion, Tree-sitter, and formatting
- `.config/git/config` — Git settings for the delta diff viewer
- `Brewfile` — Homebrew packages for WezTerm, Starship, Neovim, direnv, git-delta, Tree-sitter CLI, and ripgrep

## Link into the home directory

Run from this repository. The script preserves existing files by moving them to a `.backup` name before creating links:

```sh
./install.sh
```
