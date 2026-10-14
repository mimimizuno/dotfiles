return {
    {
        "andythigpen/nvim-coverage",
        -- Javaのjacoco XMLパーサーがneotestのXMLライブラリに依存している
        dependencies = { "nvim-lua/plenary.nvim", "nvim-neotest/neotest" },
        ft = { "java" },
        opts = {
            lang = {
                java = {
                    -- デフォルトはnvimのcwd相対でレポートを探すが、cwdとlcdのズレで
                    -- 見つからないことがあるため、代わりに今開いているファイルから
                    -- build.gradle(.kts)のあるGradleモジュールルートを探してそこを基準にする
                    coverage_file = function()
                        local root = vim.fs.root(0, { "build.gradle.kts", "build.gradle" }) or vim.fn.getcwd()
                        return root .. "/build/reports/jacoco/test/jacocoTestReport.xml"
                    end,
                },
            },
        },
        keys = {
            {
                "<leader>cv",
                function()
                    require("coverage").load(true)
                end,
                desc = "Load/toggle JaCoCo coverage signs",
            },
            {
                "<leader>cV",
                function()
                    require("coverage").summary()
                end,
                desc = "Show coverage summary",
            },
        },
    },
}
