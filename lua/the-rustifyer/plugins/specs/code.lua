-- Plugins for enhace the code experience with `Neovim`
--
local code = {}

-- Tressiter plugin for text highlighting
code.treesitter = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufRead', 'BufNewFile' },
}

code.treesitter_textobjects = 'nvim-treesitter/nvim-treesitter-textobjects'
code.treesitter_context = 'nvim-treesitter/nvim-treesitter-context'

-- Diagnostics
code.trouble = 'folke/trouble.nvim'

return code

