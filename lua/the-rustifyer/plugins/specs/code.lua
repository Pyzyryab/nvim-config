-- Plugins for enhace the code experience with `Neovim`
--
local code = {}


-- 'LSP', autocompletition and code snippets
code.lsp_zero = {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x', lazy = true, config = false,}
code.mason = {'williamboman/mason.nvim', lazy = true, event = 'VeryLazy', no_extra_config = true }
code.mason_lsp_config = {'williamboman/mason-lspconfig.nvim', lazy = true, event = 'VeryLazy', no_extra_config = true }
code.nvim_lspconfig = {'neovim/nvim-lspconfig', lazy = true, event = 'VeryLazy', no_extra_config = true }
code.luasnip = {'L3MON4D3/LuaSnip', lazy = true, event = {'BufReadPre', 'BufNewFile'}, no_extra_config = true }
code.nvim_cmp = {'hrsh7th/nvim-cmp', lazy = true, event = 'InsertEnter', no_extra_config = true }
code.cmp_nvim_lsp = {'hrsh7th/cmp-nvim-lsp', lazy = true, event = {'BufReadPre', 'BufNewFile'}, no_extra_config = true }
code.cmp_buffer = {'hrsh7th/cmp-buffer', lazy = true, event = {'BufReadPre', 'BufNewFile'}, no_extra_config = true }
code.cmp_path = {'hrsh7th/cmp-path', lazy = true, event = {'BufReadPre', 'BufNewFile'}, no_extra_config = true }
code.cmp_luasnip = {'saadparwaiz1/cmp_luasnip', lazy = true, event = {'BufReadPre', 'BufNewFile'}, no_extra_config = true }
code.friendly_snippets = {'rafamadriz/friendly-snippets', lazy = true, event = {'BufReadPre', 'BufNewFile'}, no_extra_config = true }

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
