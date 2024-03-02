-- UI related plugins of this set up
--
return {


-- bottom statusline
{ 'nvim-lualine/lualine.nvim' },

-- Winbar
{"utilyre/barbecue.nvim"},

-- Popup messages/notifications
{'rcarriga/nvim-notify'},

-- Handling transparency
{'xiyaowong/transparent.nvim'},

-- Better vim.ui
{'stevearc/dressing.nvim'},

-- Lsp visual information
{ 'linrongbin16/lsp-progress.nvim'},

{ "j-hui/fidget.nvim"},

{
    "ray-x/lsp_signature.nvim",
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
},

{
    'roobert/action-hints.nvim',
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
},
}
