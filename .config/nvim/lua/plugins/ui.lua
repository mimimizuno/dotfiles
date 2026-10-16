return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = { style = "night" },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight-night")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "tokyonight",
                globalstatus = true,
            },
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            {
                "<leader>e",
                function()
                    require("nvim-tree.api").tree.toggle({ find_file = true, focus = true })
                end,
                desc = "Toggle file explorer (focus current file)",
            },
        },
        opts = {
            update_focused_file = { enable = true },
            view = {
                adaptive_size = true,
                width = { min = 32, max = 60 },
            },
            -- LSPの警告/エラーがあるファイルにバッジを表示（親ディレクトリにも伝播）
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = true,
            },
            renderer = {
                -- 未保存のバッファ、git変更があるファイルの行全体（アイコン+名前）を
                -- 背景色付きで強調する
                highlight_modified = "all",
                highlight_git = "all",
            },
        },
        config = function(_, opts)
            require("nvim-tree").setup(opts)

            -- 未保存バッファ用の背景色（git変更色とは別系統の青系）
            local function set_tree_highlights()
                vim.api.nvim_set_hl(0, "NvimTreeModifiedFileHL", { bg = "#1f2a3d" })
                -- git変更ファイル用の背景色（gitsigns行ハイライトと同系統の色味）
                vim.api.nvim_set_hl(0, "NvimTreeGitFileDirtyHL", { bg = "#2d2a1f" })
                vim.api.nvim_set_hl(0, "NvimTreeGitFileStagedHL", { bg = "#1f2d1f" })
                vim.api.nvim_set_hl(0, "NvimTreeGitFileNewHL", { bg = "#1f2d1f" })
                vim.api.nvim_set_hl(0, "NvimTreeGitFileDeletedHL", { bg = "#2d1f24" })
            end

            set_tree_highlights()
            vim.api.nvim_create_autocmd("ColorScheme", { callback = set_tree_highlights })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        -- nvim-treesitterを`main`ブランチで使っているため、telescopeの
        -- プレビューが依存する旧API(parsers.ft_to_lang)が存在せずクラッシュする。
        -- treesitterベースのプレビューハイライトを無効化し、通常のsyntaxに
        -- フォールバックさせる。
        opts = function()
            local actions = require("telescope.actions")
            return {
                defaults = {
                    preview = {
                        treesitter = false,
                    },
                    -- 結果一覧を上、プレビューを下の縦並びにして、一覧側に画面の横幅を
                    -- フルに使わせる（横並びだと一覧が狭くファイル名が見切れるため）
                    layout_strategy = "vertical",
                    layout_config = {
                        width = 0.95,
                        vertical = {
                            preview_height = 0.6,
                        },
                    },
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.preview_scrolling_down,
                            ["<C-k>"] = actions.preview_scrolling_up,
                        },
                    },
                },
                extensions = {
                    live_grep_args = {
                        -- true だと "-"や引用符で始まらない入力は丸ごと1つの検索文字列として
                        -- 扱われ、"検索語 -g main/**"のように後ろにrg引数を続けても
                        -- 分割されず効かない。false にして常に空白区切りでトークン分割する。
                        auto_quoting = false,
                    },
                },
            }
        end,
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("live_grep_args")
        end,
        keys = {
            {
                "<leader>ff",
                function()
                    require("telescope.builtin").find_files()
                end,
                desc = "Find files",
            },
            {
                "<leader>fg",
                function()
                    require("telescope").extensions.live_grep_args.live_grep_args()
                end,
                desc = "Search in files (supports ripgrep args like -g)",
            },
            {
                "<leader>fb",
                function()
                    require("telescope.builtin").buffers()
                end,
                desc = "Find open buffers",
            },
            {
                "<leader>fc",
                function()
                    require("telescope.builtin").git_status()
                end,
                desc = "Find changed files (git status, includes untracked)",
            },
            {
                "<leader>fh",
                function()
                    require("telescope.builtin").help_tags()
                end,
                desc = "Search help",
            },
            {
                "<leader>fd",
                function()
                    require("telescope.builtin").diagnostics()
                end,
                desc = "Find diagnostics (warnings/errors)",
            },
            {
                "<leader>fs",
                function()
                    require("telescope.builtin").lsp_document_symbols()
                end,
                desc = "Find symbols in current file (imports, functions, classes...)",
            },
        },
    },
}
