-- UI related plugins of this set up
--

local ui = {}

ui.alpha = 'goolord/alpha-nvim'
ui.nui = { 'MunifTanjim/nui.nvim', no_extra_config = true }
ui.web_devicons = { 'nvim-tree/nvim-web-devicons', no_extra_config = true }

-- bottom statusline
ui.lualine = { 'nvim-lualine/lualine.nvim' }

-- Winbar
ui.barbecue = "utilyre/barbecue.nvim"

-- Popup messages/notifications
ui.notify = 'rcarriga/nvim-notify'

-- Handling transparency
ui.transparent = 'xiyaowong/transparent.nvim'

-- Better vim.ui
ui.dressing = 'stevearc/dressing.nvim'

-- Lsp visual information
ui.lsp_progress = { 'linrongbin16/lsp-progress.nvim', no_extra_config = true }

ui.lsp_signature = {
    "ray-x/lsp_signature.nvim",
    event = 'VeryLazy',
    opts = {},
    no_extra_config = true,
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
}

ui.action_hints = {
    'roobert/action-hints.nvim',
    no_extra_config = true,
    event = {'BufRead', 'BufNewFile'},
    config = function()
    require("action-hints").setup({
      template = {
        definition = { text = " ⊛", color = "#add8e6" },
        references = { text = " ↱%s", color = "#ff6666" },
      },
      use_virtual_text = true,
    })
  end,
}

return ui
