-- Plugins for enhace find/pick Neovim's capabilities
--

local plugins = {}

plugins.telescope = {
    'nvim-telescope/telescope.nvim',
--    event = 'VeryLazy',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
}

return plugins

