return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            -- サインカラムのアイコン幅がNeovimの制限(2セル)を超えてエラーになるため無効化
            -- (見出し・太字・チェックリストなどの本体の装飾には影響しない)
            sign = { enabled = false },
            -- 表の行がウィンドウ幅に収まらない時、render-markdownは行全体を隠して
            -- 仮想行として描き直す(conceal_lines)。この仕組みだと実際の行が非表示に
            -- なり、gitの変更ハイライトが乗らなくなるため、折り返しを無効化する。
            pipe_table = { wrap = false },
        },
    },
}
