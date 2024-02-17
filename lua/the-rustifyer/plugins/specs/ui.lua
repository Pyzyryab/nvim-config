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

-- Winbar
ui.barbecue = "utilyre/barbecue.nvim"

-- Popup messages/notifications
ui.notify = 'rcarriga/nvim-notify'

-- Handling transparency
ui.transparent = 'xiyaowong/transparent.nvim'

-- Better vim.ui
ui.dressing = 'stevearc/dressing.nvim'

-- Lsp progress status
ui.lsp_progress = 'linrongbin16/lsp-progress.nvim'

return ui

