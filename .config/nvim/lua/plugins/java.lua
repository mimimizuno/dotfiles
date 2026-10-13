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

                    -- Lombokの@Slf4jなどアノテーションが生成するフィールド（logなど）を
                    -- jdtlsが解決できるように、同梱のlombok.jarをjavaagentとして読み込む。
                    local lombok_jar = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
                    local jvm_args = {}
                    if vim.fn.filereadable(lombok_jar) == 1 then
                        jvm_args = { "--jvm-arg=-javaagent:" .. lombok_jar }
                    end

                    require("jdtls").start_or_attach({
                        cmd = { jdtls_bin, "-data", workspace, unpack(jvm_args) },
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
