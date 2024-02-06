-- This file holds my personal keymaps and remaps, along as the configuration for the leader key
--
-- Not all remaps may be configured here, as they could be directly configured in the plugins
-- Toggle between absolute and relative line numbers
vim.keymap.set(
    {'n', 'v'},
    '<leader>ln', 
    function()
        local enabled_rel_line_nums = vim.wo.relativenumber == true
        if enabled_rel_line_nums then
            vim.cmd('set number norelativenumber')
        else
            vim.cmd('set number relativenumber')
        end
    end,
    {
        desc = 'Toggle between absolute and relative line numbers'
    }
)

-- Opens `Newtr` file explorer 
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

----------------- General custom remaps -----------------
--
-- TODO's
-- Line start/end
-- File start/end instead of gg/G? Or isn't worth, since these two
-- are confortable?
-- 
--
-- Move to window using the <ctrl> + hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize the current windows size with <ctr> + arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Moves the selected lines in Visual mode one down (J) or one up (K)
-- TODO in 'n' and 'v' with Alt - J/K
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')

-- Mantains the cursor of the middle of the screen moving up/down
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Search terms stays in the middle
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Greatest remap ever. Thank you, theprimagean!
vim.keymap.set('x', '<leader>p', [["_dP]])

-- Yank the selected text to the system clipboard ("+y).
-- In Visual mode, it yanks the visually selected text
vim.keymap.set({'n', 'v'}, '<leader>y', [["+y]])

-- Yank from the cursor position to the end of the line
-- and copies it to the system clipboard ("+Y)
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- In summary, pressing <leader>d in Normal or Visual mode will delete
-- the selected text and place it into the black hole register,
vim.keymap.set({'n', 'v'}, '<leader>d', [["_d]])

----------------- Plugin's remaps  -----------------
-- TODO move this remapss to their specific configuration files

-- Neotree
vim.keymap.set({'n', 'v'}, '<leader>nt', '<cmd>Neotree<CR>', noremap_silent)
vim.keymap.set({'n', 'v'}, '<leader>e', '<cmd>Neotree toggle<CR>', noremap_silent)
