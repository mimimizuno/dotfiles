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

            -- 今のファイルのテストクラスだけをGradleで実行する
            local function run_current_test(bufnr)
                local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 200, false)
                local package_name = nil
                for _, line in ipairs(lines) do
                    local pkg = line:match("^%s*package%s+([%w%.]+)%s*;")
                    if pkg then
                        package_name = pkg
                        break
                    end
                end
                local class_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t:r")
                local fqcn = package_name and (package_name .. "." .. class_name) or class_name

                local repo_root = vim.fs.root(bufnr, "gradlew")
                local module_root = vim.fs.root(bufnr, { "build.gradle.kts", "build.gradle" })
                if not repo_root or not module_root then
                    vim.notify("Gradleプロジェクトのルートが見つかりませんでした", vim.log.levels.ERROR)
                    return
                end
                local module_name = vim.fn.fnamemodify(module_root, ":t")

                -- インタラクティブシェル(.zshrc起動中のstarship/zoxide等)に文字が
                -- 割り込んでコマンドが分断されるのを避けるため、chansendで後から
                -- 打ち込むのではなく、:terminalにコマンドを直接渡して実行する。
                local cmd = ("cd %s && direnv exec . ./gradlew :%s:test --tests %s"):format(
                    vim.fn.shellescape(repo_root), module_name, vim.fn.shellescape(fqcn)
                )
                vim.cmd("split | terminal " .. cmd)
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = function(event)
                    vim.keymap.set("n", "<leader>tt", function()
                        run_current_test(event.buf)
                    end, { buffer = event.buf, desc = "Run this test class (Gradle)" })

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
