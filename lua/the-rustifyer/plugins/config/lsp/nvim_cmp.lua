-- `nvim cmp` configuration
--
return {
    dependencies = {
        { 'L3MON4D3/LuaSnip' }
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

        -- Mapping <CR> via autopairs
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

        -- LSP pictograms
        local lspkind = require('lspkind')

        cmp.setup({
            -- if you don't know what is a "source" in nvim-cmp read this:
            -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/autocomplete.md#adding-a-source
            sources = {
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'path' },
                { name = 'luasnip',   keyword_length = 2 },
                { name = 'buffer',    keyword_length = 3 },
                { name = 'calc' },
                { name = 'treesitter' },
            },
            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.recently_used,
                    require("clangd_extensions.cmp_scores"),
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                -- confirm completion item
                ['<CR>'] = cmp.mapping.confirm({ select = false }),

                -- trigger completion menu
                ['<C-Space>'] = cmp.mapping.complete(),

                -- Cycle the completition menu
                ['<Tab>'] = cmp_action.luasnip_supertab(),
                ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),

                -- scroll up and down the documentation window
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),

                -- navigate between snippet placeholders
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            }),

            -- note: if you are going to use lsp-kind (another plugin)
            -- replace the line below with the function from lsp-kind
            -- formatting = lsp_zero.cmp_format(),
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol', -- show only symbol annotations
                    maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    -- can also be a function to dynamically calculate max width such as
                    -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                    ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    show_labelDetails = true, -- show labelDetails in menu. Disabled by default

                    -- The function below will be called before any actual modifications from lspkind
                    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    -- before = function (entry, vim_item)
                    -- ...
                    -- return vim_item
                    -- end
                })
            },
        })
        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })
        --[[ -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }
            })
        }) ]]
    end,
}
