-- 'LSP', autocompletition and code snippets
--

return {
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x', lazy = true, event = 'VeryLazy'},
  {'williamboman/mason.nvim', lazy = true, event = 'VeryLazy'},
  {'williamboman/mason-lspconfig.nvim', lazy = true, event = 'VeryLazy'},
  {'neovim/nvim-lspconfig', lazy = true, event = 'VeryLazy'},
--  {'L3MON4D3/LuaSnip', lazy = true, event = 'BufEnter',},
  {'hrsh7th/nvim-cmp', lazy = true, event = 'BufEnter',},
  {'hrsh7th/cmp-nvim-lsp', lazy = true, event = 'BufEnter',},
  {'hrsh7th/cmp-buffer', lazy = true, event = 'BufEnter',},
  {'hrsh7th/cmp-path', lazy = true, event = 'BufEnter',},
  {'saadparwaiz1/cmp_luasnip', lazy = true, event = 'BufEnter',},
  {'rafamadriz/friendly-snippets', lazy = true, event = 'BufEnter',},
}

