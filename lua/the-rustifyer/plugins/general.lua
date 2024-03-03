-- General purpose plugins that are typically needed by others, that they are for enhace
-- the capabilities of others or that they are just general purpose plugins
return {
    -- General procedures and functionality library
    { 'nvim-lua/plenary.nvim' },

    -- Better concurrency
    { 'kevinhwang91/promise-async' },

    -- Better vim.ui
    {
        'stevearc/dressing.nvim',
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },
}
