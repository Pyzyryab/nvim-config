-- `nvim cmp` configuration
--
return {
    dependencies = {
        {'L3MON4D3/LuaSnip'},
    },
    config = function()
        -- Here is where you configure the autocompletion settings.
        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_cmp()

        -- And you can configure cmp even more, if you want to.
        local cmp = require('cmp')
        local cmp_action = lsp_zero.cmp_action()

        -- this is the function that loads the extra snippets
        -- from rafamadriz/friendly-snippets
        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
            -- if you don't know what is a "source" in nvim-cmp read this:
            -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/autocomplete.md#adding-a-source
            sources = {
                {name = 'path'},
                {name = 'nvim_lsp'},
                {name = 'luasnip', keyword_length = 2},
                {name = 'buffer', keyword_length = 3},
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            -- default keybindings for nvim-cmp are here:
            -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/README.md#keybindings-1
            mapping = cmp.mapping.preset.insert({
                -- confirm completion item
                ['<Enter>'] = cmp.mapping.confirm({ select = true }),

                -- trigger completion menu
                ['<C-Space>'] = cmp.mapping.complete(),

                -- scroll up and down the documentation window
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),

                -- navigate between snippet placeholders
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            }),

            -- note: if you are going to use lsp-kind (another plugin)
            -- replace the line below with the function from lsp-kind
            formatting = lsp_zero.cmp_format(),
        })
    end,
}

