-- Plugins for enhace the code experience with `Neovim`
--
local code = {}

-- 'LSP', autocompletition and code snippets
code.lsp_zero = {'VonHeikemen/lsp-zero.nvim'}
code.mason = {'williamboman/mason.nvim', no_extra_config = true }
code.mason_lsp_config = {'williamboman/mason-lspconfig.nvim', config = true, no_extra_config = true }
code.nvim_lspconfig = {'neovim/nvim-lspconfig', config = true}

code.nvim_jdtls = {'mfussenegger/nvim-jdtls', ft = 'java', no_extra_config = true}

code.luasnip = {'L3MON4D3/LuaSnip', event = {'BufReadPre', 'BufNewFile'}, no_extra_config = true }
code.nvim_cmp = {'hrsh7th/nvim-cmp', event = 'InsertEnter'}
code.cmp_nvim_lsp = {'hrsh7th/cmp-nvim-lsp', event = {'BufReadPre', 'BufNewFile'}, no_extra_config = true }
code.cmp_buffer = {'hrsh7th/cmp-buffer', event = {'BufReadPre', 'BufNewFile'}, no_extra_config = true }
code.cmp_path = {'hrsh7th/cmp-path', event = {'BufReadPre', 'BufNewFile'}, no_extra_config = true }
code.cmp_luasnip = {'saadparwaiz1/cmp_luasnip', event = {'BufReadPre', 'BufNewFile'}, no_extra_config = true }
code.friendly_snippets = {'rafamadriz/friendly-snippets', event = {'BufReadPre', 'BufNewFile'}, no_extra_config = true }

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

