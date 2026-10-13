return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            -- 変更した行全体を背景色でハイライト（VSCode風の強調）
            linehl = true,
            numhl = false,
            -- render-markdown.nvimの見出し等の背景(priority=4096)に埋もれないよう、
            -- gitsignsの行ハイライトの優先度をそれより高くする
            sign_priority = 5000,
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                -- 変更点（hunk）間のジャンプ
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next")
                    end
                end, "次の変更点へジャンプ")

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev")
                    end
                end, "前の変更点へジャンプ")

                -- 変更内容の確認・操作
                map("n", "<leader>hp", gitsigns.preview_hunk, "変更点をプレビュー（ポップアップ）")
                map("n", "<leader>hi", gitsigns.preview_hunk_inline, "変更点をプレビュー（インライン表示）")
                map("n", "<leader>hs", gitsigns.stage_hunk, "変更点をstage")
                map("n", "<leader>hr", gitsigns.reset_hunk, "変更点をreset（取り消し）")
                map("n", "<leader>hb", gitsigns.blame_line, "この行のblameを表示")
                map("n", "<leader>hd", gitsigns.diffthis, "ファイル全体のdiffを表示")
                map("n", "<leader>ht", gitsigns.toggle_current_line_blame, "行末blame表示を切替")
            end,
        },
        config = function(_, opts)
            require("gitsigns").setup(opts)

            -- tokyonight-nightの配色に合わせた、変更行の背景色（控えめな色味）
            local function set_line_highlights()
                vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = "#1f2d1f" })
                vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = "#2d2a1f" })
                vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { bg = "#2d1f24" })
            end

            set_line_highlights()
            vim.api.nvim_create_autocmd("ColorScheme", { callback = set_line_highlights })
        end,
    },
}
