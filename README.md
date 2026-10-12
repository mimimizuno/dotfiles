# dotfiles

Personal configuration files for macOS.

## Install the applications

Install WezTerm, Starship, and Neovim with Homebrew:

```sh
brew bundle --file ~/dotfiles/Brewfile
```

## Included

- `.config/wezterm/wezterm.lua` — WezTerm settings and key bindings
- `.config/starship.toml` — Starship prompt
- `.config/nvim/init.vim` — Neovim settings adapted from the existing Vim configuration
- `Brewfile` — Homebrew packages for WezTerm, Starship, and Neovim

## Link into the home directory

Run from this repository. The commands preserve existing files by moving them to a `.backup` name before creating links:

```sh
[ ! -e "$HOME/.config/wezterm/wezterm.lua" ] || mv "$HOME/.config/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua.backup"
ln -s "$PWD/.config/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"

[ ! -e "$HOME/.config/starship.toml" ] || mv "$HOME/.config/starship.toml" "$HOME/.config/starship.toml.backup"
ln -s "$PWD/.config/starship.toml" "$HOME/.config/starship.toml"

mkdir -p "$HOME/.config/nvim"
[ ! -e "$HOME/.config/nvim/init.vim" ] || mv "$HOME/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim.backup"
ln -s "$PWD/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim"
```
