local servers = {
    "bashls",
    "cssls",
    "html",
    "jsonls",
    "lua_ls",
    "pyright",
    "ruby_lsp",
    "ts_ls",
}
local mason_servers = vim.list_extend(vim.deepcopy(servers), { "jdtls" })

return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            for _, server in ipairs(servers) do
                vim.lsp.config(server, { capabilities = capabilities })
            end

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = mason_servers,
                -- JDTLS is started through nvim-jdtls with a project workspace.
                automatic_enable = servers,
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            ensure_installed = { "black", "google-java-format", "prettierd", "shfmt", "stylua" },
            auto_update = false,
            run_on_start = true,
        },
    },
}
