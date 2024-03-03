-- UI enhacement to the LSP plugins
--
return {
    -- Show the loading progress and the state of the servers in the statusline
    { 'linrongbin16/lsp-progress.nvim'},

    -- SHow the messages between clients and servers, the loading status and extra info
    { "j-hui/fidget.nvim"},

    --
    {
        "ray-x/lsp_signature.nvim",
        event = 'VeryLazy',
        opts = {},
        config = function(_, opts) require 'lsp_signature'.setup(opts) end
    },

    --
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
