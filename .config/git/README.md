# Git設定

設定本体は隣の[`config`](config)です。Gitはこのファイルを`~/.config/git/config`として読み込みます。

- `core.pager = delta` — 通常のdiffをdeltaで表示
- `interactive.diffFilter = delta --color-only` — 対話的なGit操作のdiffに色を適用
- `navigate = true` — delta内の差分移動を有効化
- `line-numbers = true` — 行番号を表示
- `side-by-side = true` — 変更前後を左右に表示
- `core.editor = nvim -c startinsert` — GitのコミットメッセージをNeovimで開き、挿入モードから開始
- `core.quotepath = false` — ファイル名の日本語など非ASCII文字を`\343\201\202`のような8進数エスケープではなくそのまま表示

delta本体はルートの[`Brewfile`](../../Brewfile)からHomebrewで導入します。
