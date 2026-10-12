return {
    {
        "zaakiy/line-justice.nvim",
        dependencies = { "luukvbaal/statuscol.nvim" },
        lazy = false,
        config = function()
            local line_justice = require("line-justice")
            line_justice.setup()

            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                relculright = true,
                segments = {
                    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                    {
                        sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = true, wrap = true },
                        click = "v:lua.ScSa",
                    },
                    { text = { line_justice.segment }, click = "v:lua.ScLa" },
                },
            })
        end,
    },
}
