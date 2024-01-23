-- This file holds my personal keymaps and remaps, along as the configuration for the leader key
--
-- Not all remaps may be configured here, as they could be directly configured in the plugins

local noremap_silent = { noremap = true, silent = true };

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
--
-- Telescope remaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, noremap_silent)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, noremap_silent)
vim.keymap.set('n', '<leader>fb', builtin.buffers, noremap_silent)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, noremap_silent)

local colorscheme = builtin.colorscheme
vim.keymap.set('n', '<leader>cs', colorscheme, noremap_silent)

