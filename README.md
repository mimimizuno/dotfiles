# dotfiles

Personal configuration files for macOS.

## Install the applications

Install WezTerm, Starship, and Neovim with Homebrew:

```sh
brew bundle --file ~/dotfiles/Brewfile
```

## Included

- `.zshrc` — Zsh configuration
- `.config/wezterm/wezterm.lua` — WezTerm settings and key bindings
- `.config/starship.toml` — Starship prompt
- `.config/nvim/init.vim` — Neovim settings adapted from the existing Vim configuration
- `Brewfile` — Homebrew packages for WezTerm, Starship, and Neovim

## Link into the home directory

Run from this repository. The script preserves existing files by moving them to a `.backup` name before creating links:

```sh
./install.sh
```
