# Neovim設定

このディレクトリは`~/.config/nvim`にリンクされます。設定の読み込みは[`init.lua`](init.lua)から始まり、プラグイン管理と機能別設定を読み込みます。

## ファイル構成

- [`init.lua`](init.lua) — 基本オプション、共通キーバインド、言語別インデント、診断表示
- [`lua/`](lua/README.md) — Lua設定の構成と各サブディレクトリへの目次

## 基本操作

Leaderキーはスペースです。

### ファイル探索

| キー | 動作 |
| --- | --- |
| `<Space>e` | ファイルツリーを開閉（今のファイルの行に自動フォーカス） |
| `<Space>ff` | ファイル名を検索 |
| `<Space>fg` | ファイル内容を検索 |
| `<Space>fb` | 開いているバッファを検索 |
| `<Space>fh` | Neovimヘルプを検索 |
| `<Space>fd` | プロジェクト全体の警告・エラー（diagnostics）を検索 |
| `<Space>fs` | 現在のファイルのシンボル（import・関数・クラス等）を検索 |
| `gx` | カーソル下のURL/リンクをブラウザで開く（Neovim標準機能） |

### LSP（接続時のみ）

| キー | 動作 |
| --- | --- |
| `gd` | 定義へ移動 |
| `gr` | 参照を検索 |
| `K` | ホバー情報を表示 |
| `<Space>rn` | シンボル名を変更 |
| `<Space>ca` | コードアクション |
| `<Space>cf` | 現在のファイルを整形 |
| `[d` / `]d` | 前/次の警告・エラーへジャンプ |
| `<Space>cd` | カーソル位置の警告・エラー詳細を表示 |
| `<Space>ci` | この関数を呼んでいる場所を表示（incoming calls） |
| `<Space>co` | この関数が呼んでいる先を表示（outgoing calls） |

### Git（gitsigns.nvim、変更があるファイルを開いた時のみ）

| キー | 動作 |
| --- | --- |
| `]c` / `[c` | 次/前の変更点（hunk）へジャンプ |
| `<Space>hp` | 変更点をプレビュー（ポップアップ） |
| `<Space>hi` | 変更点をプレビュー（インライン表示） |
| `<Space>hs` | 変更点をstage |
| `<Space>hr` | 変更点をreset（取り消し） |
| `<Space>hd` | ファイル全体のdiffを表示 |
| `<Space>hb` | その行のgit blameを表示 |
| `<Space>ht` | 行末blame表示を切替 |

### ウィンドウ分割（Vim標準機能）

| コマンド | 動作 |
| --- | --- |
| `:split` / `Ctrl-w s` | 水平分割（上下） |
| `:vsplit` / `Ctrl-w v` | 垂直分割（左右） |
| `Ctrl-w h/j/k/l` | 分割間を移動 |
| `Ctrl-w q` | 現在のウィンドウを閉じる |
| `Ctrl-w o` | 現在のウィンドウ以外を閉じる |
| `Ctrl-w =` | 分割の大きさを均等化 |
| `Ctrl-w +` / `-` | 高さを増減 |
| `Ctrl-w <` / `>` | 幅を増減 |
| `Ctrl-w T` | 現在のウィンドウを新しいタブに切り離す |

### その他

| キー | 動作 |
| --- | --- |
| `jj`（挿入モード） | ノーマルモードへ戻る |
| `<Esc><Esc>`（ノーマルモード） | 検索ハイライトを消す |

行番号は[LineJusticeプラグイン](lua/plugins/line-numbers.lua)で、各行に絶対行番号とカーソルからの相対距離を並べて表示します。カーソル行は相対距離を空欄にします。カーソル位置を追いやすいよう、現在行の横線と現在列の縦線も表示します。80桁目の目安線もあります。

## 補完対象と言語サポート

nvim-cmpはLSP、スニペット、ファイルパス、現在のバッファ内の単語を補完候補として表示します。LSPはBash、CSS、HTML、JSON、Lua、Python、Ruby、JavaScript/TypeScript、Javaを設定しています。Tree-sitterはこれらに加えてMarkdown、Vim、YAMLなどの構文ハイライトを設定しています。

JavaはJDTLSを使用します。Maven/Gradleプロジェクトでは、ビルドファイルから読み込まれた依存ライブラリの型やAPIも補完に利用されます。フレームワーク特有の機能には専用の言語サーバーが必要な場合があります。Java用設定と必要条件は[plugins README](lua/plugins/README.md#java)を参照してください。

## セットアップ

1. ルートREADMEの手順でHomebrewアプリを入れ、`./install.sh`を実行します。
2. `nvim`を起動します。lazy.nvimがプラグインを導入し、MasonがLSPサーバーやフォーマッターを導入します。
3. Javaファイルを開き、初回インストール完了後に必要ならファイルを開き直します。

JavaのLSPにはJava 21以降が必要です。現在の環境ではOpenJDK 23を使用しています。
