-- Plugins for enhace buffers when they can be seen or perceived
-- as "editor" things
return {
    mini_animate = 'echasnovski/mini.animate',

    -- Indentation guides
    indent_blankline = 'lukas-reineke/indent-blankline.nvim',
    mini_identscope = 'echasnovski/mini.indentscope',

    -- Statuline with the LSP symbols
    winbar = 'SmiteshP/nvim-navic',

    -- highlighting
    illuminate = 'RRethy/vim-illuminate',

    -- todo's
    todo_comments = 'folke/todo-comments.nvim',

    -- Autocomplete pairs of code symbols like '(', '{'...
    autopairs = 'windwp/nvim-autopairs',

    -- Handling line/block commentary
    comments = 'numToStr/Comment.nvim',

    -- Set cursor on the last editing position on reopen
    lastplace = { 'farmergreg/vim-lastplace', event = 'VeryLazy', no_extra_config = true },

    -- Better scrool movements
    scrool_mov = {
        "karb94/neoscroll.nvim",
        config = function()
            require('neoscroll').setup {}
        end
    },

    -- Better tracking of the editor's cursor position
    cursor_pos = {
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
    url_open = {
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
