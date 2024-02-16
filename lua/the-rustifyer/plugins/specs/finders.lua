-- Plugins for enhace find/pick Neovim's capabilities
--

local finders = {}

finders.telescope = 'nvim-telescope/telescope.nvim'
finders.fzf_native = 'nvim-telescope/telescope-fzf-native.nvim'

finders.flash = 'folke/flash.nvim'
finders.spectre = 'nvim-pack/nvim-spectre'

-- Find yanked content to the vim registers
finders.neoclip = 'AckslD/nvim-neoclip.lua'

return finders
