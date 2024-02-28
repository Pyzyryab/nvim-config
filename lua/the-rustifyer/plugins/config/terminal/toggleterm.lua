-- Embeeds a terminal(s) within an active Neovim session
--
--I typically don't use thing plugins when I am using a Unix based system,
--because I have `fg`, but it's fine to have it sometimes when I am on W2
--and I don't want to have like a million of tabs in Windows Terminal
--
return {
    -- event = 'VeryLazy',
    cmd = 'ToggleTerm',
    version = "*",
    config = true,
    opts = {
        size = 10,
        open_mapping = '<leader>to',
        insert_mappings = true,
        terminal_mappings = true,
        highlights = {
            Normal = { link = "Normal" },
            NormalNC = { link = "NormalNC" },
            NormalFloat = { link = "NormalFloat" },
            FloatBorder = { link = "FloatBorder" },
            StatusLine = { link = "StatusLine" },
            StatusLineNC = { link = "StatusLineNC" },
            WinBar = { link = "WinBar" },
            WinBarNC = { link = "WinBarNC" },
        },
        -- autochdir = true,
        -- start_in_insert = true,
        winbar = {
            enabled = false,
            -- name_formatter = nil
        },
        float_opts = {
            border = "curved",
        },
        dir = 'git_dir'
    }
}


-- event = 'VeryLazy',
-- version = "*",
-- config = function()
--     require('toggleterm').setup({
--         size = 20,
--         insert_mappings = true,
--         terminal_mappings = true,
--         -- open_mapping = [[<leader>to]],
--         -- autochdir = true,
--         start_in_insert = true,
--         winbar = {
--             enabled = false,
--             -- name_formatter = nil
--         }
--     })
-- end
