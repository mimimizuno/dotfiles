export AWS_CA_BUNDLE=~/.ca-certificates/jamf-managed_ca_bundle.pem

## .zshrcの変更を検知して、プロンプト表示のたびに自動でsourceする
_zshrc_mtime=$(stat -f %m ~/.zshrc 2>/dev/null)
_reload_zshrc_if_changed() {
    local mtime
    mtime=$(stat -f %m ~/.zshrc 2>/dev/null)
    if [[ "$mtime" != "$_zshrc_mtime" ]]; then
        _zshrc_mtime=$mtime
        source ~/.zshrc
        echo ".zshrcを再読込しました"
    fi
}
precmd_functions+=(_reload_zshrc_if_changed)

# Common Settings
alias vim='nvim'
alias ll='ls -laG'
## 出力を表示しながらクリップボードにコピー
copy() {
    tee >(pbcopy)
}

# Git aliases
alias gc='git commit -v'
alias gac='git add . && git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gs='git status'
alias gr='git restore'
alias grp='git restore -p'
alias gl='git log --oneline --graph --decorate --all'
alias glb='git log --oneline --graph --decorate'
alias gb='git branch'
alias gswd='git switch develop'
alias gpl='git pull'
alias gmd='git merge develop'
alias greset='git reset HEAD~1'

## zsh completion
fpath=(/opt/homebrew/opt/gradle-completion/share/zsh/site-functions $fpath)

autoload -Uz compinit
compinit
_comp_options+=(globdots)
zstyle ':completion:*' menu select

## Remove existing completion for gsw
unalias gsw 2>/dev/null
compdef -d gsw 2>/dev/null

## Git add
unalias ga 2>/dev/null

ga() {
    if (( $# == 0 )); then
        git add .
    else
        git add "$@"
    fi
}

## ga: Gitの変更ファイルのみ補完
_ga() {
    local -a files

    files=("${(@f)$(git -c core.quotePath=false ls-files \
        --modified --others --exclude-standard 2>/dev/null)}")

    _describe 'changed files' files
}

compdef _ga ga

## Git switch
gsw() {
    git switch "$@"
}

## gsw: local branches only
_gsw() {
    local -a branches

    branches=("${(@f)$(git branch --format='%(refname:short)' 2>/dev/null)}")

    _describe 'local branches' branches
}

compdef _gsw gsw

## Git push
gpu() {
    local branch
    branch=$(git branch --show-current)

    if [[ -z "$branch" ]]; then
        echo "現在のブランチを取得できませんでした。"
        return 1
    fi

    git push -u origin "$branch"
}

## Git diff
unalias gd gdh gds 2>/dev/null
gd() {
    git diff "${@/#-n/--name-only}"
}

gdh() {
    git diff HEAD "${@/#-n/--name-only}"
}

gds() {
    git diff --staged "${@/#-n/--name-only}"
}

## Git show (HEADから何個前かを数字で指定、省略時はHEAD)
unalias gsh 2>/dev/null
gsh() {
    if (( $# == 0 )); then
        git show HEAD
    else
        git show "HEAD~$1"
    fi
}

## code review
function grb() {
    git fetch origin
    git switch develop
    git branch -D "$1" 2>/dev/null
    git switch --track "origin/$1"
}
export PATH="$HOME/.local/bin:$PATH"

# Starship prompt
eval "$(starship init zsh)"

## zoxide (cdの代替、よく使うディレクトリに素早く移動)
eval "$(zoxide init zsh --cmd cd)"

## fzf (Ctrl+Rの履歴検索やCtrl+Tのファイル選択をあいまい検索化)
if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi

## zoxideの候補が複数あるときにfzfで選ぶ
zi() {
    local dir
    dir=$(zoxide query -l | fzf) && cd "$dir"
}

## MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
## MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

## direnv
eval "$(direnv hook zsh)"

## Local project environment
envrc() {
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null)

    if [[ -z "$git_root" ]]; then
        echo "Gitリポジトリ内で実行してください。"
        return 1
    fi

    touch .envrc

    if ! grep -qxF ".envrc" "$git_root/.git/info/exclude"; then
        echo ".envrc" >> "$git_root/.git/info/exclude"
    fi

    echo ".envrc を作成し、Gitの追跡対象から除外しました。"
}
