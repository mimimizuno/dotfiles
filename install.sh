#!/bin/sh
# Link the dotfiles in this repository into the home directory.
# Existing files are preserved by moving them to a `.backup` name first.

set -eu

cd "$(dirname "$0")"
repo_dir="$PWD"

link() {
    src="$repo_dir/$1"
    dest="$HOME/$1"

    mkdir -p "$(dirname "$dest")"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        mv "$dest" "$dest.backup"
        echo "Backed up $dest to $dest.backup"
    fi

    ln -sfn "$src" "$dest"
    echo "Linked $dest -> $src"
}

link ".zshrc"
link ".config/wezterm/wezterm.lua"
link ".config/starship.toml"
link ".config/nvim/init.vim"
link ".config/git/config"
