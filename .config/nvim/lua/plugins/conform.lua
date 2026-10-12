return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                html = { "prettierd" },
                css = { "prettierd" },
                json = { "prettierd" },
                sh = { "shfmt" },
                bash = { "shfmt" },
            },
            format_on_save = function()
                return { timeout_ms = 1000, lsp_format = "fallback" }
            end,
        },
        keys = {
            {
                "<leader>cf",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                desc = "Format buffer",
            },
        },
    },
}
