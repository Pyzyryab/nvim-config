-- Embeeds a terminal(s) within an active Neovim session
--
--I typically don't use thing plugins when I am using a Unix based system,
--because I have `fg`, but it's fine to have it sometimes when I am on W2
--and I don't want to have like a million of tabs in Windows Terminal
--
return {
    event = 'VeryLazy',
    version = "*",
    config = true,
    opts = {
        size = 10,
        -- autochdir = true,
        -- start_in_insert = true,
        winbar = {
            enabled = false,
            -- name_formatter = nil
        }
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
