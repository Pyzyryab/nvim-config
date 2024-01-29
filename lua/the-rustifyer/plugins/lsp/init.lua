-- 'LSP', autocompletition and code snippets
--

return {
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x', lazy = true, config = false,},
  {'williamboman/mason.nvim', lazy = true, event = 'VeryLazy'},
  {'williamboman/mason-lspconfig.nvim', lazy = true, event = 'VeryLazy'},
  {'neovim/nvim-lspconfig', lazy = true, event = 'VeryLazy'},
  {'L3MON4D3/LuaSnip', lazy = true, event = {'BufReadPre', 'BufNewFile'},},
  {'hrsh7th/nvim-cmp', lazy = true, event = 'InsertEnter',},
  {'hrsh7th/cmp-nvim-lsp', lazy = true, event = {'BufReadPre', 'BufNewFile'},},
  {'hrsh7th/cmp-buffer', lazy = true, event = {'BufReadPre', 'BufNewFile'},},
  {'hrsh7th/cmp-path', lazy = true, event = {'BufReadPre', 'BufNewFile'},},
  {'saadparwaiz1/cmp_luasnip', lazy = true, event = {'BufReadPre', 'BufNewFile'},},
  {'rafamadriz/friendly-snippets', lazy = true, event = {'BufReadPre', 'BufNewFile'},},
}

