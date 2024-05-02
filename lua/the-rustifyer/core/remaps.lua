-- This file holds my personal remaps and keybindings for general Neovim actions/workflows
-- The plugin keymaps are directly configured on the 'which-key' plugin configuration file

----------------- General custom remaps -----------------
--

local noremapsilent = { noremap = true, silent = true }

-- Opens `Newtr` file explorer
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Opens the Newtr file explorer' })

-- Remap tab and shift+tab in normal and visual mode to indent/unindent
vim.api.nvim_set_keymap('n', '<Tab>', '>>', noremapsilent)
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', noremapsilent)
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', noremapsilent)
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', noremapsilent)

-- Move to window using the <ctrl> + hjkl keys
vim.keymap.set('n', "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set('n', "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set('n', "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set('n', "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Go to prev/next Neovim tab page
vim.keymap.set('n', '<M-p>',  '<Cmd>:-tabnext<CR>', { desc = "Go to the previous tab page", remap = false })
vim.keymap.set('n', '<M-n>',  '<Cmd>:+tabnext<CR>', { desc = "Go to the next tab page", remap = false })
--TODO: they aren't working on terminal mode
vim.keymap.set('t', '<M-p>',  '[[<Esc>:-tabnext<CR>]]', { desc = "Go to the previous tab page", remap = false })
vim.keymap.set('t', '<M-n>',  '[[<Esc>:+tabnext<CR>]]', { desc = "Go to the next tab page", remap = false })

-- Resize the current windows size with <ctr> + arrow keys
vim.keymap.set('n', "<C-Up>", "<Cmd> resize -2<CR>", { desc = "Increase window height" })
vim.keymap.set('n', "<C-Down>", "<Cmd> resize +2<CR>", { desc = "Decrease window height" })
vim.keymap.set('n', "<C-Left>", "<Cmd> vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set('n', "<C-Right>", "<Cmd> vertical resize +2<CR>", { desc = "Increase window width" })

-- Moves the selected lines in Visual mode one down (J) or one up (K)
-- TODO: in 'n' and 'v' with Alt - J/K
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
vim.keymap.set('x', '<leader>p', "\"_dP")

-- Yank the selected text to the system clipboard ("+y).
-- In Visual mode, it yanks the visually selected text
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])

-- Yank from the cursor position to the end of the line
-- and copies it to the system clipboard ("+Y)
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- In summary, pressing <leader>d in Normal or Visual mode will delete
-- the selected text and place it into the black hole register,
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- This is going to get The Primagean cancelled X)
-- But seriously, is not only useful for preserving the content while on vertical visual,
-- but also helps with Telescope to not close it but easily leave insert mode while
-- typing something to search without having to hit <Esc>
vim.keymap.set('i', '<C-c>', '<Esc>')
