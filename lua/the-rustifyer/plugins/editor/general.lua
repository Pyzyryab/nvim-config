return {
    -- Set cursor on the last editing position on reopen
    { 'farmergreg/vim-lastplace', event = 'VeryLazy' },

    -- Cursor animations while moving
    {
        'echasnovski/mini.animate',
        enabled = false,
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            cursor = { enable = true, },
            -- Vertical scroll
            scroll = { enable = true, },
            -- Window resize
            resize = { enable = true, },
            -- Window open
            open = { enable = true, },
            -- Window close
            close = { enable = true, },
        }
    },

    -- highlighting
    {
        'RRethy/vim-illuminate',
    },

    -- Better scrool movements
    {
        "karb94/neoscroll.nvim",
        config = function()
            require('neoscroll').setup {}
        end
    },

    -- Better tracking of the editor's cursor position
    {
        'gen740/SmoothCursor.nvim',
        event = 'VeryLazy',
        config = function()
            vim.fn.sign_define('smoothcursor_v', { text = ' ' })
            vim.fn.sign_define('smoothcursor_V', { text = '' })
            vim.fn.sign_define('smoothcursor_i', { text = '' })
            vim.fn.sign_define('smoothcursor_�', { text = '' })
            vim.fn.sign_define('smoothcursor_R', { text = '󰊄' })
            require('smoothcursor').setup({
                cursor = '▷',
                fg = '#8aa872'
                -- type = 'matrix'
            })
        end
    },

    -- URL open
    {
        "sontungexpt/url-open",
        branch = "mini",
        event = { 'BufReadPost', 'BufNewFile' },
        cmd = "URLOpenUnderCursor",
        config = function()
            local status_ok, url_open = pcall(require, "url-open")
            if not status_ok then
                return
            end
            url_open.setup({})
        end,
    },
}

