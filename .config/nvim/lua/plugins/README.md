# Neovimプラグイン

lazy.nvimがこのディレクトリのLuaファイルを読み込みます。機能を追加・変更するときは、対応するファイルを編集してください。

| ファイル | 内容 |
| --- | --- |
| [`ui.lua`](ui.lua) | Tokyonight、lualine、nvim-tree、Telescope |
| [`completion.lua`](completion.lua) | nvim-cmp、LSP/スニペット/パス/バッファ補完 |
| [`line-numbers.lua`](line-numbers.lua) | LineJusticeとstatuscol.nvimで絶対番号と相対距離を併記 |
| [`lsp.lua`](lsp.lua) | Mason、一般のLSPサーバー、Mason管理のツール |
| [`java.lua`](java.lua) | Java用JDTLSの起動とプロジェクト単位のワークスペース |
| [`treesitter.lua`](treesitter.lua) | Tree-sitter文法の導入と構文ハイライト |
| [`conform.lua`](conform.lua) | 保存時と`<Space>cf`でのコード整形 |
| [`gitsigns.lua`](gitsigns.lua) | 変更行のサイン・背景色表示とhunk操作キーバインド |
| [`markdown.lua`](markdown.lua) | render-markdown.nvimでMarkdownをnvim内で装飾表示 |

## 言語サーバーと補完

MasonでBash、CSS、HTML、JSON、Lua、Python、Ruby、TypeScript/JavaScriptのサーバーとJavaのJDTLSを導入します。Javaは通常のLSP自動起動ではなく、`nvim-jdtls`からプロジェクトごとのworkspaceを指定して起動します。

補完UIは[`completion.lua`](completion.lua)にあり、候補の供給元はLSP、LuaSnipスニペット、ファイルパス、バッファです。Tree-sitterは補完エンジンではなく、構文解析とハイライトを担当します。

## Java

[`java.lua`](java.lua)がJavaバッファを開いたときにJDTLSを起動します。プロジェクトルートはGradle/Mavenのラッパーや設定ファイル、`.git`を目印に判定します。各プロジェクトのJDTLS workspaceはNeovimのデータディレクトリに分けて保存します。

MasonがJDTLSのインストールを終える前にJavaファイルを開いた場合は、インストール後にそのファイルを開き直してください。Java用フォーマッターは`google-java-format`です。各言語のフォーマッター対応は[`conform.lua`](conform.lua)を確認してください。

## キーバインド

Leaderキーはスペースです。主な操作は`<Space>e`でツリー、`<Space>ff`でファイル検索、`<Space>fg`で内容検索、`<Space>cf`で整形です。LSP接続時の移動やリネームは親の[Neovim README](../../README.md#基本操作)にまとめています。

行番号は各行を「絶対番号 + カーソルからの距離」で表示し、カーソル行の距離部分は空欄になります。`line-numbers.lua`がLineJusticeの表示セグメントをstatuscol.nvimに設定します。
