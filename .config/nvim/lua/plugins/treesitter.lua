return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local languages = {
                "bash",
                "css",
                "html",
                "java",
                "javascript",
                "jsx",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "ruby",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            }

            require("nvim-treesitter").setup()
            require("nvim-treesitter").install(languages)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "bash",
                    "css",
                    "html",
                    "java",
                    "javascript",
                    "javascriptreact",
                    "json",
                    "lua",
                    "markdown",
                    "python",
                    "ruby",
                    "typescript",
                    "typescriptreact",
                    "vim",
                    "yaml",
                },
                callback = function(event)
                    pcall(vim.treesitter.start, event.buf)
                end,
            })
        end,
    },
}
