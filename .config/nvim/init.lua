-- ~/.local/state is root-owned on this machine; keep Neovim state in a
-- user-writable location for built-in LSP logs and plugin state.
vim.env.XDG_STATE_HOME = vim.env.HOME .. "/.local/share/nvim-state"

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Core options, migrated from the previous Vimscript configuration.
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "cp932", "euc-jp", "sjis" }
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.opt.ambiwidth = "double"
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.clipboard = { "unnamed", "unnamedplus" }

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.virtualedit = "onemore"
vim.opt.smartindent = true
vim.opt.showmatch = true
vim.opt.laststatus = 3
vim.opt.wildmode = { "list:longest" }

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.hlsearch = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.list = true
vim.opt.listchars = {
    tab = ">-",
    trail = "-",
    extends = ">",
    precedes = "<",
    nbsp = "%",
}
vim.opt.mouse = "a"
vim.opt.colorcolumn = "80"
vim.opt.visualbell = true

-- Move by screen lines when text is wrapped.
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<Down>", "gj")
vim.keymap.set("n", "<Up>", "gk")

vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Clear search highlight" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Leave insert mode" })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Per-language indentation from the existing Vim configuration.
local indentation = {
    python = 4,
    java = 4,
    ruby = 2,
    javascript = 2,
    html = 2,
    css = 2,
    typescript = 2,
    javascriptreact = 2,
    typescriptreact = 2,
}

local indent_group = vim.api.nvim_create_augroup("filetype_indent", { clear = true })
for filetype, width in pairs(indentation) do
    vim.api.nvim_create_autocmd("FileType", {
        group = indent_group,
        pattern = filetype,
        callback = function()
            vim.opt_local.tabstop = width
            vim.opt_local.softtabstop = width
            vim.opt_local.shiftwidth = width
        end,
    })
end

-- Simple automatic closing pairs.
vim.keymap.set("i", "(", "()<Left>")
vim.keymap.set("i", "{", "{}<Left>")
vim.keymap.set("i", "[", "[]<Left>")
vim.keymap.set("i", '"', '""<Left>')
vim.keymap.set("i", "'", "''<Left>")

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250

-- nvim-tree recommends disabling netrw when using it as the file explorer.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.diagnostic.config({
    float = { border = "rounded" },
    severity_sort = true,
    underline = true,
    virtual_text = true,
})

-- hover(K)やsignature helpなど、LSPの浮動ウィンドウ全般に枠線をつけて見やすくする
vim.o.winborder = "rounded"

require("config.lazy")
require("config.lsp-keymaps")
