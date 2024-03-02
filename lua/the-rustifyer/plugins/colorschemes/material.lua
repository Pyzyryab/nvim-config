return {
    lazy = false,
    priority = 1000,
    config = function()
        require('material').setup({
            -- lualine_style = 'default' -- the default style
            lualine_style = 'stealth' -- the stealth style
        })

        -- vim.g.material_style = 'deep ocean'
    end
}
