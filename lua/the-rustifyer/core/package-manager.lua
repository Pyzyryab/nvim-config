-- `lazy.nvim` configuration, the set up plugin manager
--
local consts = require('the-rustifyer.core.constants')
local utils = require('the-rustifyer.core.globals')
local procs = require('the-rustifyer.utils.procedures')

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

local lua_ext = '.lua'
local glob_pattern = utils.path.join(consts.dirs.lua, consts.dirs.specs) .. utils.path.sep .. '*' .. lua_ext
local lazy_specs = vim.fn.glob(glob_pattern)

-- Detect all the plugins under whatever..plugins/ and all the children folders
local detected_modules = vim.split(lazy_specs, "\n", { trimempty = true })

local lazy_plugins = {}
for _, module_ in ipairs(detected_modules) do
    local module_path_split = vim.split(module_, utils.path.sep)
    local category = module_path_split[#module_path_split]:gsub(lua_ext, '')
    local plugin = require(procs.generate_mod_require_path(consts.mods.specs, category))

    for key, value in pairs(plugin) do
        local target = type(value) == 'string' and {value} or value
        -- early guards
        local opt_extra_conf = nil
        if target.no_extra_config ~= nil then goto continue end
        opt_extra_conf = procs.load_plugin_extra_config(category, key, target) -- skip if declared for performance
        ::continue::

        -- effectively loading the plugin to the table that will be passed to lazy.nvim
        lazy_plugins[#lazy_plugins + 1] = (opt_extra_conf ~= nil) and opt_extra_conf or target
    end
end

local lazy = require('lazy')
lazy.setup(lazy_plugins, {
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

