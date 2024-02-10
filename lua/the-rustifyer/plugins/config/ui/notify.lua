-- Configuration for the plugin that manages Neovim notifications via UI components
--
return {
    lazy = false,
    keys = {
        {
            "<leader>un", --- TODO pending to be moved to the remaps file,
            -- and being set up by which-key, but with <leader>nu instead pls
            -- so we can deactivate specific keys in normal mode (c, s, d, u)
            -- and we don't have to wait which-key to be triggered
            function()
                require("notify").dismiss({ silent = true, pending = true })
            end,
            desc = "Dismiss all Notifications",
        },
    },
    opts = {
        timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
        on_open = function(win)
            vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
    },
    init = function()
        vim.notify = require("notify")
    end,
}

