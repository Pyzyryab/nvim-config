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

-- Popup messages/notifications
ui.notify = 'rcarriga/nvim-notify'

-- Handling transparency
ui.transparency = {'xiyaowong/transparent.nvim', event = {'UIEnter'}, lazy = false, no_extra_config = true}

-- Better vim.ui
ui.dressing = 'stevearc/dressing.nvim'

return ui

