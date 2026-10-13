vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local function map(lhs, rhs, description)
            vim.keymap.set("n", lhs, rhs, {
                buffer = event.buf,
                desc = description,
                silent = true,
            })
        end

        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gr", vim.lsp.buf.references, "Find references")
        map("K", vim.lsp.buf.hover, "Show documentation")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")

        -- 警告/エラー(diagnostics)の確認
        map("[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, "Previous diagnostic")
        map("]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, "Next diagnostic")
        map("<leader>cd", vim.diagnostic.open_float, "Show diagnostic details")

        -- 依存関係（この関数を呼んでいる/呼んでいる先）の確認
        map("<leader>ci", vim.lsp.buf.incoming_calls, "Who calls this (incoming calls)")
        map("<leader>co", vim.lsp.buf.outgoing_calls, "What this calls (outgoing calls)")
    end,
})
