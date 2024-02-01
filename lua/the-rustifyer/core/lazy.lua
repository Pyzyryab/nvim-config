-- Getting lazy.nvim as the package manager for the set up
-- Lazy only will be fetched and cloned if isn't already on the system

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

-- Detect all the plugins under whatever..plugins/ and all the children folders
local plugins = vim.split(vim.fn.glob(vim.fn.stdpath('config') .. "the-rustifyer/modules/plugins/*.lua"), "\n", { trimempty = true })

local lazy = require('lazy')
lazy.setup(plugins, {
    defaults = {
        lazy = true,
    },
    install = {
        colorscheme = { 'habamax', },
    },
    checker = { enabled = true }, -- automatically check for plugin update_in_insert
    cache = {
	enabled = true,
    	disable_events = { "UIEnter", "BufReadPre" },
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

