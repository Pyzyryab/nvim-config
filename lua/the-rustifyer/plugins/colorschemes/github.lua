return {
    -- priority = 1000, -- make sure to load this before all the other start plugins
    event = 'VeryLazy',
    config = function()
        require('github-theme').setup({
            -- ...
        })

        -- vim.cmd('colorscheme github_dark')
    end,
}
