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
        },
    },
}
