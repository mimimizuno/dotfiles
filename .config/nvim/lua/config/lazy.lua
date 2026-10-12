local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local result = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })

    if vim.v.shell_error ~= 0 then
        error("Could not install lazy.nvim:\n" .. result)
    end
end

vim.opt.rtp:prepend(lazypath)

-- ~/.local/state is not writable on this machine. Keep lazy.nvim's runtime
-- state under its already writable data directory instead.
local lazy_state = vim.fn.stdpath("data") .. "/lazy"

require("lazy").setup({
    spec = { { import = "plugins" } },
    install = { colorscheme = { "tokyonight-night" } },
    checker = { enabled = false },
    pkg = { enabled = false, cache = lazy_state .. "/pkg-cache.lua" },
    readme = { root = lazy_state .. "/readme" },
    state = lazy_state .. "/state.json",
})
