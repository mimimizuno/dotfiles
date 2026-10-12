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
    end,
})
