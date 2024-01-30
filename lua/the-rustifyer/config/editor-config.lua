-- This file holds my personal editor's configuration and settings
--

vim.opt.guicursor = '' -- fat cursor enabled (even on insert mode)
vim.opt.termguicolors = true

-- Access colors present in 256 colorspace
vim.g.base16_colorspace = 256
-- Make vim background transparent to work alongside transparent terminal backgrounds
vim.g.base16_background_transparent = 1

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

vim.opt.colorcolumn = '120' -- maybe a function per type of language in the opened current buffer?

-- Enabling folding capabilities
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

