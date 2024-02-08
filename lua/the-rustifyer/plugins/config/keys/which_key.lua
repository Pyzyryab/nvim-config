-- Configuration for the which-key plugin, which takes care
-- of showing a popup with the keymaps/remaps defined for the setup
--
return {
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 1000
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
}

