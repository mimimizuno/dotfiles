# dotfiles

macOSで使うシェル、ターミナル、Git、Neovimの設定を管理するリポジトリです。設定ファイルの内容は各ディレクトリのREADMEを参照してください。

## ドキュメント

- [設定ファイルの目次](.config/README.md)
- [Zsh設定README](ZSH.md)
- [Neovim設定](.config/nvim/README.md)
- [WezTerm設定](.config/wezterm/README.md)
- [Starship設定](.config/starship.README.md)
- [Git設定](.config/git/README.md)

## 初期セットアップ

Homebrewでツールをインストールします。

```sh
brew bundle --file ~/dotfiles/Brewfile
```

続けて、リポジトリのルートでリンクを作成します。既存の設定ファイルがある場合、`install.sh`は`.backup`という名前に移してからシンボリックリンクを作ります。

```sh
cd ~/dotfiles
./install.sh
```

## Zsh

[`.zshrc`](.zshrc)にはStarshipとdirenvの初期化、zoxide/fzfによるあいまい検索での`cd`、Git用の短縮コマンド、変更ファイルやブランチの補完を設定しています。`vim`は`nvim`の別名です。`ga`は引数なしなら全変更ファイルをステージし、引数ありなら指定したパスをステージします。

主な短縮コマンドは`gs`（status）、`gc`（commit）、`gp`（push）、`gd`（diff）、`gds`（staged diff）、`gdh`（HEADとの差分）です。

## Homebrew管理

[`Brewfile`](Brewfile)にWezTerm、Starship、Neovim、direnv、git-delta、Tree-sitter CLI、ripgrep、zoxide、fzfを記載しています。Neovim内のプラグインやLSPサーバーは別途Neovim起動時にlazy.nvimとMasonが管理します。
