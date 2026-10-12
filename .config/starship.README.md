# Starshipプロンプト

設定本体は同じ階層の[`starship.toml`](starship.toml)です。`~/.config/starship.toml`としてリンクされ、`.zshrc`から`starship init zsh`を読み込んで表示します。

## 表示内容

- 左側: カレントディレクトリ、Gitブランチ、Gitの変更状態。その下に入力位置を表示
- 右側: 1秒以上かかったコマンドの実行時間、ユーザー名、✨、現在時刻
- ディレクトリは最大10階層分を表示し、長いパスは`…/`で省略
- `Documents`、`Downloads`、`Music`、`Pictures`はアイコンに置き換え
- 書き込み不可のディレクトリにはロックアイコンを表示
- Vimのノーマルモードでは入力記号の代わりに緑の`V`を表示
- AWSとGoogle Cloudのコンテキスト表示は無効

## 変更するとき

色、記号、左右どちらに出すかは[`starship.toml`](starship.toml)の`format`、`right_format`と各モジュール設定で変更できます。設定変更後は新しいシェルを開くか、現在のZshで次を実行して反映します。

```sh
exec zsh
```

絵文字やアイコンが正しく表示されない場合は、ターミナルでNerd Font対応フォントを使っているか確認してください。
