-- `lazy.nvim` configuration, the set up plugin manager
--
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    spec = {
        {import = 'the-rustifyer.plugins'},
        {import = 'the-rustifyer.plugins.ui'},
        {import = 'the-rustifyer.plugins.lsp'},
        {import = 'the-rustifyer.plugins.code'},
        {import = 'the-rustifyer.plugins.editor'},
        {import = 'the-rustifyer.plugins.colorschemes'},
    },
    defaults = {
        lazy = true,
    },
    install = {
        colorscheme = { 'catpuccin', },
    },
    checker = { enabled = true }, -- automatically check for plugin update_in_insert
    cache = {
	    enabled = true,
--	    disable_events = { "UIEnter", "BufReadPre" },
    },
    reset_packpath = true,
    performance = {
        rtp = {
	    paths = {},
            -- disable some rtp plugins
            disabled_plugins = {
                'gzip',
                -- 'matchit',
                -- 'matchparen',
                -- 'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
})

