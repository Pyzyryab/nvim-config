-- Constant values across the set up
--
local utils = require('the-rustifyer.core.globals')
local procs = require('the-rustifyer.utils.procedures')

local consts = {}

consts.distro_name = 'the-rustifyer'

consts.lua = 'lua'
consts.core = 'core'

consts.plugins = 'plugins'
consts.specs = 'specs'
consts.config = 'config'

consts.utils = 'utils'
consts.procedures = 'procedures'

local mods = {}
mods.root = consts.distro_name
mods.plugins = procs.generate_mod_require_path(mods.root, consts.plugins)
mods.specs = procs.generate_mod_require_path(mods.plugins, consts.specs)
mods.plugins_config = procs.generate_mod_require_path(mods.plugins, consts.config)

local dirs = {}
dirs.root = consts.distro_name
dirs.plugins = utils.path.join(dirs.root, consts.plugins)
dirs.specs = utils.path.join(dirs.plugins, consts.specs)
dirs.plugins_config = utils.path.join(dirs.plugins, consts.config)

dirs.nvim = vim.fn.stdpath('config')
dirs.nvim_data = vim.fn.stdpath('data')
dirs.lua = utils.path.join(dirs.nvim, consts.lua)

--
consts.mods = mods
consts.dirs = dirs

-- LSP specific configurations per server
local lsp = {
    -- Filetypes passed to clangd to be configured
    clangd_fts = { "c", 'cc', "cpp", 'h', 'hpp', 'cppm', 'ixx', "objc", "objcpp", "cuda" },
}
consts.lsp = lsp


return consts
