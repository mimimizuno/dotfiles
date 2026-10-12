# Neovim Lua設定

Lua設定の入口は親ディレクトリの[`init.lua`](../init.lua)です。このディレクトリ以下は役割ごとに分けています。

- [`config/`](config/README.md) — プラグインマネージャーの起動とLSP共通キーバインド
- [`plugins/`](plugins/README.md) — UI、補完、LSP、Java、Tree-sitter、フォーマッターの設定

新しいプラグインを追加するときは、`plugins/`に機能別ファイルを作成します。共通の起動処理やプラグインをまたぐ設定は`config/`に置きます。
