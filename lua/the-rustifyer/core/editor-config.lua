-- This file holds my personal editor's configuration and settings
--

vim.opt.guicursor = '' -- fat cursor enabled (even on insert mode)
vim.opt.termguicolors = true

-- Save localoptions to session file
vim.opt.sessionoptions:append("localoptions")

-- Access colors present in 256 colorspace
vim.g.base16_colorspace = 256

-- Set transparency
-- vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi NonText guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi VertSplit guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi StatusLine guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi StatusLineNC guibg=NONE ctermbg=NONE ]]

-- For a floating window (popup menu), set transparency
-- vim.cmd [[ hi NormalNC guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi NormalFloat guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi Neotree guibg=NONE ctermbg=NONE ]]

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

