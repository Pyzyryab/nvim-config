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

local nvim_dir = vim.fn.stdpath('config')
local lua_dir = "\\lua"
local me = "the-rustifyer"
local tr_dir = lua_dir .. "\\" .. me 
local plugins_dir = tr_dir .. "\\plugins"
local specs_path =  plugins_dir .. "\\specs"
local lua_ext = '.lua' 
local lazy_specs = vim.fn.glob(nvim_dir .. specs_path .. "\\*" .. lua_ext)

print(specs_path)
print('lazy_specs: ', lazy_specs)
-- Detect all the plugins under whatever..plugins/ and all the children folders
local detected_modules = vim.split(lazy_specs, "\n", { trimempty = true })

local function load_plugin_extra_config(plug_name, lazy_plug)
    print('Loading extra configuration for: ', plug_name)
    local plug_config_path = me .. '.plugins.config.ui.' .. plug_name
    local plug_config_mod = require(plug_config_path)

    -- Adding any extra keys loaded for the plugin definition
    for key, value in pairs(plug_config_mod) do
        print('Iterating INNER over: ', key)
        lazy_plug[key] = value -- todo add the mod name
    end

    print('Final plug spec: ', plug_name .. " - " .. vim.inspect(lazy_plug))

    return lazy_plug
end

local lazy_plugins = {}
for a, module_ in ipairs(detected_modules) do
    print('A?:', a .. " - " .. module_)
    local _, end_pos = module_:find(lua_dir)
    local lua_module = module_:sub(end_pos + 2, -5) -- +2 because last is non inclusive + the path separator
    local lm, ot = lua_module:gsub('\\', '.') 
    local plugin = require(lm)
    print('Module: ', vim.inspect(plugin))
    --lazy_plugins[#lazy_plugins + 1] = plugin
    for key, value in pairs(plugin) do
        -- Load the extra configuration for the plugins
        print('Iterating over: ', key .. " - " .. vim.inspect(value))
        -- Add the nested table directly to lazy_plugins
        if type(value) == 'table' then
            lazy_plugins[#lazy_plugins + 1] = load_plugin_extra_config(key, value)
        end
    end
end

local lazy = require('lazy')
lazy.setup(lazy_plugins, {
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

