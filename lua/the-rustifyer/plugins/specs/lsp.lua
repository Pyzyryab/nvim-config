-- LSP core plugins
--
return {
    lsp_zero = 'VonHeikemen/lsp-zero.nvim',
    mason_lsp_config = {'williamboman/mason-lspconfig.nvim', no_extra_config = true },
    nvim_lspconfig = { 'neovim/nvim-lspconfig', config = true, event = { 'BufReadPre', 'BufNewFile' }, },

    nvim_jdtls = { 'mfussenegger/nvim-jdtls', ft = 'java', no_extra_config = true },

    luasnip = { 'L3MON4D3/LuaSnip', event = { 'BufReadPre', 'BufNewFile' }, no_extra_config = true },
    nvim_cmp = { 'hrsh7th/nvim-cmp', event = 'InsertEnter' },
    cmp_nvim_lsp = { 'hrsh7th/cmp-nvim-lsp', event = { 'BufReadPre', 'BufNewFile' }, no_extra_config = true },
    cmp_buffer = { 'hrsh7th/cmp-buffer', event = { 'BufReadPre', 'BufNewFile' }, no_extra_config = true },
    cmp_path = { 'hrsh7th/cmp-path', event = { 'BufReadPre', 'BufNewFile' }, no_extra_config = true },
    cmp_luasnip = { 'saadparwaiz1/cmp_luasnip', event = { 'BufReadPre', 'BufNewFile' }, no_extra_config = true },
    friendly_snippets = { 'rafamadriz/friendly-snippets', event = { 'BufReadPre', 'BufNewFile' }, no_extra_config = true },
    lspkind = { 'onsails/lspkind.nvim', event = { 'BufReadPre', 'BufNewFile' }, no_extra_config = true },
}

