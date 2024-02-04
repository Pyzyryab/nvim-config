-- Plugins for enhace the code experience with `Neovim`
--
local code = {}


-- Tressiter plugin for text highlighting
code.treesitter = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufRead', 'BufNewFile' },
}

-- Indentation guides
code.indent_blankline = 'lukas-reineke/indent-blankline.nvim' 
code.mini_identscope = 'echasnovski/mini.indentscope'

return code
