-- Winbar
return {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    event = { 'BufReadPre', 'BufNewFile' },
    version = '*',
    dependencies = {
        {
            'SmiteshP/nvim-navic',
            opts = {
                icons = {
                    File          = "󰈙 ",
                    Module        = " ",
                    Namespace     = "󰌗 ",
                    Package       = " ",
                    Class         = "󰌗 ",
                    Method        = "󰆧 ",
                    Property      = " ",
                    Field         = " ",
                    Constructor   = " ",
                    Enum          = "󰕘",
                    Interface     = "󰕘",
                    Function      = "󰊕 ",
                    Variable      = "󰆧 ",
                    Constant      = "󰏿 ",
                    String        = "󰀬 ",
                    Number        = "󰎠 ",
                    Boolean       = "◩ ",
                    Array         = "󰅪 ",
                    Object        = "󰅩 ",
                    Key           = "󰌋 ",
                    Null          = "󰟢 ",
                    EnumMember    = " ",
                    Struct        = "󰌗 ",
                    Event         = " ",
                    Operator      = "󰆕 ",
                    TypeParameter = "󰊄 ",
                },
                lsp = {
                    auto_attach = true,
                    preference = nil,
                },
                highlight = false,
                separator = " > ",
                depth_limit = 0,
                depth_limit_indicator = "..",
                safe_output = true,
                lazy_update_context = false,
                click = false,
                format_text = function(text)
                    return text
                end,
            }
        },
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        exclude_filetypes = { 'netrw', 'toggleterm', 'alpha', --[['neo-tree']] },

    },
    config = function()
        require('barbecue').setup({
            create_autocmd = false, -- prevent barbecue from updating itself automatically
        })

        vim.api.nvim_create_autocmd({
            'WinScrolled', -- or WinResized on NVIM-v0.9 and higher
            'BufWinEnter',
            'CursorHold',
            'InsertLeave',

            -- include this if you have set `show_modified` to `true`
            'BufModifiedSet',
        }, {
            group = vim.api.nvim_create_augroup('barbecue.updater', {}),
            callback = function()
                require('barbecue.ui').update()
            end,
        })
    end
}
