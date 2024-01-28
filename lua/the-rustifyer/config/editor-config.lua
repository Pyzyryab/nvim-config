-- This file holds my personal editor's configuration and settings
--
-- Most of them are the oness under `vim.opt`

vim.opt.guicursor = '' -- fat cursor enabled (even on insert mode)
vim.opt.termguicolors = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4 -- indentation's configuration (tabs at 4, please!)
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.optscrolloff = 8 -- not sure about this one, let's try it anyway
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

vim.opt.colorcolumn = '80' -- maybe a function per type of language in the opened current buffer?


