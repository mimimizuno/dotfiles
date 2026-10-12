# Neovim設定

このディレクトリは`~/.config/nvim`にリンクされます。設定の読み込みは[`init.lua`](init.lua)から始まり、プラグイン管理と機能別設定を読み込みます。

## ファイル構成

- [`init.lua`](init.lua) — 基本オプション、共通キーバインド、言語別インデント、診断表示
- [`lua/`](lua/README.md) — Lua設定の構成と各サブディレクトリへの目次

## 基本操作

Leaderキーはスペースです。

| キー | 動作 |
| --- | --- |
| `<Space>e` | ファイルツリーを開閉 |
| `<Space>ff` | ファイル名を検索 |
| `<Space>fg` | ファイル内容を検索 |
| `<Space>fb` | 開いているバッファを検索 |
| `<Space>fh` | Neovimヘルプを検索 |
| `<Space>cf` | 現在のファイルを整形 |
| `gd` | 定義へ移動（LSP接続時） |
| `gr` | 参照を検索（LSP接続時） |
| `K` | ホバー情報を表示（LSP接続時） |
| `<Space>rn` | シンボル名を変更（LSP接続時） |
| `<Space>ca` | コードアクション（LSP接続時） |
| `jj`（挿入モード） | ノーマルモードへ戻る |
| `<Esc><Esc>`（ノーマルモード） | 検索ハイライトを消す |

## 補完対象と言語サポート

nvim-cmpはLSP、スニペット、ファイルパス、現在のバッファ内の単語を補完候補として表示します。LSPはBash、CSS、HTML、JSON、Lua、Python、Ruby、JavaScript/TypeScript、Javaを設定しています。Tree-sitterはこれらに加えてMarkdown、Vim、YAMLなどの構文ハイライトを設定しています。

JavaはJDTLSを使用します。Maven/Gradleプロジェクトでは、ビルドファイルから読み込まれた依存ライブラリの型やAPIも補完に利用されます。フレームワーク特有の機能には専用の言語サーバーが必要な場合があります。Java用設定と必要条件は[plugins README](lua/plugins/README.md#java)を参照してください。

## セットアップ

1. ルートREADMEの手順でHomebrewアプリを入れ、`./install.sh`を実行します。
2. `nvim`を起動します。lazy.nvimがプラグインを導入し、MasonがLSPサーバーやフォーマッターを導入します。
3. Javaファイルを開き、初回インストール完了後に必要ならファイルを開き直します。

JavaのLSPにはJava 21以降が必要です。現在の環境ではOpenJDK 23を使用しています。
