return {
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local root_markers = {
                "gradlew",
                "mvnw",
                "pom.xml",
                "build.gradle",
                "build.gradle.kts",
                "settings.gradle",
                "settings.gradle.kts",
                ".git",
            }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = function(event)
                    local jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
                    if vim.fn.executable(jdtls_bin) ~= 1 then
                        vim.notify("JDTLS is still installing. Reopen this Java file after Mason finishes.", vim.log.levels.WARN)
                        return
                    end

                    local root = vim.fs.root(event.buf, root_markers) or vim.fn.getcwd()
                    local workspace = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.sha256(root):sub(1, 16)
                    vim.fn.mkdir(workspace, "p")

                    require("jdtls").start_or_attach({
                        cmd = { jdtls_bin, "-data", workspace },
                        root_dir = root,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        settings = {
                            java = {
                                configuration = {
                                    updateBuildConfiguration = "interactive",
                                },
                            },
                        },
                    }, nil, { bufnr = event.buf })
                end,
            })
        end,
    },
}
