-- UI related plugins of this set up
--

local ui = {}

ui.alpha = 'goolord/alpha-nvim'
ui.nui = {'MunifTanjim/nui.nvim', no_extra_config = true}
ui.web_devicons = {'nvim-tree/nvim-web-devicons', no_extra_config = true}

-- bottom statusline
ui.lualine = {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
}

return ui
