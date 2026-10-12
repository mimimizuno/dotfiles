# Neovimの基盤設定

このディレクトリには個別プラグインではなく、Neovim全体の起動やLSP共通動作を置いています。

- [`lazy.lua`](lazy.lua) — lazy.nvimを必要なら取得し、`lua/plugins/`のプラグイン定義を読み込みます。プラグイン状態はNeovimのデータ領域に保存します。
- [`lsp-keymaps.lua`](lsp-keymaps.lua) — LSPがバッファに接続されたときに、定義・参照・ホバー・名前変更・コードアクションのキーを設定します。

基本オプションやLeaderキーは親ディレクトリの[`init.lua`](../../init.lua)にあります。
