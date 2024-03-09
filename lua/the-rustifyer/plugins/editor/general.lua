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
        enabled = false,
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { 'lsp' },
            },
        },
        config = function(_, opts)
            require('illuminate').configure(opts)

            local function map(key, dir, buffer)
                vim.keymap.set('n', key, function()
                    require('illuminate')['goto_' .. dir .. '_reference'](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference', buffer = buffer })
            end

            map(']]', 'next')
            map('[[', 'prev')

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map(']]', 'next', buffer)
                    map('[[', 'prev', buffer)
                end,
            })
        end,
        keys = {
            { ']]', desc = 'Next Reference' },
            { '[[', desc = 'Prev Reference' },
        },
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
            require('smoothcursor').setup({
                type = "default", -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".

                -- cursor = "", -- Cursor shape (requires Nerd Font). Disabled in fancy mode.
                texthl = "SmoothCursor", -- Highlight group. Default is { bg = nil, fg = "#FFD400" }. Disabled in fancy mode.
                linehl = nil, -- Highlights the line under the cursor, similar to 'cursorline'. "CursorLine" is recommended. Disabled in fancy mode.

                fancy = {
                    enable = true, -- enable fancy mode
                    head = { cursor = "󰝥", texthl = "SmoothCursorAqua", linehl = nil }, -- false to disable fancy head
                    body = {
                        { cursor = "󰝥", texthl = "SmoothCursorAqua" },
                        { cursor = "󰝥", texthl = "SmoothCursorAqua" },
                        { cursor = "●", texthl = "SmoothCursorAqua" },
                        { cursor = "●", texthl = "SmoothCursorAqua" },
                        { cursor = "•", texthl = "SmoothCursorAqua" },
                        { cursor = ".", texthl = "SmoothCursorAqua" },
                        { cursor = ".", texthl = "SmoothCursorAqua" },
                    },
                    tail = { cursor = nil, texthl = "SmoothCursor" } -- false to disable fancy tail
                },
                autostart = true, -- Automatically start SmoothCursor
                always_redraw = true, -- Redraw the screen on each update
                flyin_effect = nil, -- Choose "bottom" or "top" for flying effect
                speed = 25,    -- Max speed is 100 to stick with your current position
                intervals = 35, -- Update intervals in milliseconds
                priority = 10, -- Set marker priority
                timeout = 3000, -- Timeout for animations in milliseconds
                threshold = 1, -- Animate only if cursor moves more than this many lines
                disable_float_win = false, -- Disable in floating windows
                enabled_filetypes = nil, -- Enable only for specific file types, e.g., { "lua", "vim" }
                disabled_filetypes = {'Alpha'}, -- Disable for these file types, ignored if enabled_filetypes is set. e.g., { "TelescopePrompt", "NvimTree" }
                -- Show the position of the latest input mode positions.
                -- A value of "enter" means the position will be updated when entering the mode.
                -- A value of "leave" means the position will be updated when leaving the mode.
                -- `nil` = disabled
                show_last_positions = nil,
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
