-- `nvim cmp` configuration
--
return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        { 'L3MON4D3/LuaSnip' },
        -- TODO: adjust the event correctly for the ones below
        { 'hrsh7th/cmp-nvim-lsp',         event = { 'BufReadPre', 'BufNewFile' }, },
        { 'hrsh7th/cmp-buffer',           event = { 'BufReadPre', 'BufNewFile' }, },
        { 'hrsh7th/cmp-cmdline',          event = { 'BufReadPre', 'BufNewFile' }, },
        { 'hrsh7th/cmp-nvim-lua',         event = { 'BufReadPre', 'BufNewFile' }, },
        { 'hrsh7th/cmp-path',             event = { 'BufReadPre', 'BufNewFile' }, },
        { 'hrsh7th/cmp-calc',             event = { 'BufReadPre', 'BufNewFile' }, },
        { 'ray-x/cmp-treesitter',         event = { 'BufReadPre', 'BufNewFile' }, },
        { 'saadparwaiz1/cmp_luasnip',     event = { 'BufReadPre', 'BufNewFile' }, },
        { 'rafamadriz/friendly-snippets', event = { 'BufReadPre', 'BufNewFile' }, },
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
        require("luasnip").config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })
        require('luasnip.loaders.from_vscode').lazy_load()

        -- Mapping <CR> via autopairs
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

        -- LSP pictograms
        local lspkind = require('lspkind')
        -- luasnip
        local luasnip = require('luasnip')
        -- Set this check up for nvim-cmp tab mapping
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            -- if you don't know what is a "source" in nvim-cmp read this:
            -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/autocomplete.md#adding-a-source
            sources = {
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'path' },
                { name = 'luasnip',                keyword_length = 2 },
                { name = 'buffer',                 keyword_length = 3 },
                { name = 'calc' },
                { name = 'treesitter' },
                { name = 'nvim_lua' },
            },
            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.recently_used,
                    require("clangd_extensions.cmp_scores"), --TODO: enable it only when attach to clangd
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
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- confirm completion item
                ['<CR>'] = cmp.mapping.confirm({ select = false }),

                -- trigger completion menu
                ['<C-Space>'] = cmp.mapping.complete(),

                -- Cycle the completition menu
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- scroll up and down the documentation window
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),

                -- navigate between snippet placeholders
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            }),

            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text', -- show only symbol annotations
                    maxwidth = 50,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    -- can also be a function to dynamically calculate max width such as
                    -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                    ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                })
            },
        })

        -- `/` cmdline setup.
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })
        -- `:` cmdline setup.
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
                option = {
                    ignore_cmds = { 'Man', '!' }
                }
            }),
        })
    end,
}
