-- UI related plugins of this set up
--

local ui = {}

ui.alpha = 'goolord/alpha-nvim'
ui.nui = 'MunifTanjim/nui.nvim'
ui.web_devicons = 'nvim-tree/nvim-web-devicons'

-- bottom statusline
ui.lualine = {
    'nvim-lualine/lualine.nvim',
    setup_callback = true,
    event = 'VeryLazy',
}

return ui
