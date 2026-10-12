# Zsh設定

設定本体はルートの[`.zshrc`](.zshrc)です。`install.sh`が`~/.zshrc`にリンクします。設定を編集した後、現在のシェルに反映するには次を実行します。

```sh
source ~/.zshrc
```

## 起動時に読み込むもの

- Starshipでプロンプトを表示
- direnvのZshフックを有効化
- HomebrewのGradle補完関数を補完パスに追加
- ドットで始まるファイルもコマンド補完候補に含める
- 候補を選択式メニューで表示

## 基本設定

- `vim`は`nvim`の別名
- `ll`は詳細表示と隠しファイル表示を行う`ls -laG`
- `copy`は標準入力を画面に表示しながらmacOSのクリップボードにもコピー
- `.local/bin`とRancher Desktopの実行ファイルを`PATH`に追加
- Jamf管理の証明書バンドルを`AWS_CA_BUNDLE`に設定

## Gitの短縮コマンド

| コマンド | 実行内容 |
| --- | --- |
| `gs` | `git status` |
| `gc` | `git commit -v`（コミットメッセージを詳細表示） |
| `gac` | `git add .`の後にコミット |
| `gcm "message"` | メッセージを指定してコミット |
| `gp` | `git push` |
| `gpu` | 現在のブランチを`origin`へpushし、upstreamを設定 |
| `gr` / `grp` | `git restore` / 対話的な`git restore -p` |
| `gl` / `glb` | グラフ付きのGitログ |
| `gb` | ブランチ一覧 |
| `gpl` | `git pull` |
| `gswd` / `gmd` | `develop`へ切替 / `develop`をマージ |
| `greset` | 直前のコミットを取り消す（`HEAD~1`へ移動） |
| `gd` / `gdh` / `gds` | 作業ツリー / HEADとの差 / ステージ済みのdiff |
| `grb <branch>` | `origin`を取得し、`develop`に切り替えてリモートブランチを追跡 |

`gd`、`gdh`、`gds`には`-n`を渡すと、差分ではなく変更ファイル名だけを表示します。

## Gitコマンドの補完と関数

- `ga`は引数なしなら`git add .`、パスを渡すと指定したファイルを追加します。補完にはGitの未追跡・変更済みファイルを表示します。
- `gsw <branch>`は`git switch`を実行し、ローカルブランチ名を補完候補にします。
- `grb <branch>`はリモートブランチを取得してから、`develop`へ切り替え、指定したリモートブランチを追跡するローカルブランチに切り替えます。

## direnv用の`.envrc`

プロジェクトのGitリポジトリ内で`envrc`を実行すると、現在のディレクトリに`.envrc`を作成し、Gitリポジトリの`.git/info/exclude`に追加します。`.envrc`は秘密情報やローカル環境設定を置くため、リポジトリにはコミットされません。

`.envrc`に環境変数などを記述したら、direnvが表示する案内に従って許可します。direnvは許可したファイルの内容を読み込む仕組みです。
