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

    -- Autosave
    {
        "Pocco81/auto-save.nvim",
        event = 'VeryLazy',
        config = function()
            require("auto-save").setup {
                enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
                execution_message = {
                    message = function() -- message to print on save
                        return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
                    end,
                    dim = 0.18,                      -- dim the color of `message`
                    cleaning_interval = 1250,        -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
                },
                trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
                -- function that determines whether to save the current buffer or not
                -- return true: if buffer is ok to be saved
                -- return false: if it's not ok to be saved
                condition = function(buf)
                    local fn = vim.fn
                    local utils = require("auto-save.utils.data")

                    if
                        fn.getbufvar(buf, "&modifiable") == 1 and
                        utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
                        return true -- met condition(s), can save
                    end
                    return false -- can't save
                end,
                write_all_buffers = false, -- write all buffers when the current one meets `condition`
                debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
                callbacks = {  -- functions to be executed at different intervals
                    enabling = nil, -- ran when enabling auto-save
                    disabling = nil, -- ran when disabling auto-save
                    before_asserting_save = nil, -- ran before checking `condition`
                    before_saving = nil, -- ran before doing the actual save
                    after_saving = nil -- ran after doing the actual save
                }
            }
        end,
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
                linehl = nil,            -- Highlights the line under the cursor, similar to 'cursorline'. "CursorLine" is recommended. Disabled in fancy mode.

                fancy = {
                    enable = true, -- enable fancy mode
                    head = { cursor = "󰝥", texthl = "SmoothCursorAqua", linehl = nil }, -- false to disable fancy head
                    body = {
                        { cursor = "󰝥", texthl = "SmoothCursorYellow" },
                        { cursor = "󰝥", texthl = "SmoothCursorYellow" },
                        { cursor = "●", texthl = "SmoothCursorYellow" },
                        { cursor = "●", texthl = "SmoothCursorYellow" },
                        { cursor = "•", texthl = "SmoothCursorYellow" },
                        { cursor = ".", texthl = "SmoothCursorYellow" },
                        { cursor = ".", texthl = "SmoothCursorYellow" },
                    },
                    tail = { cursor = nil, texthl = "SmoothCursor" } -- false to disable fancy tail
                },
                autostart = true,                                    -- Automatically start SmoothCursor
                always_redraw = true,                                -- Redraw the screen on each update
                flyin_effect = nil,                                  -- Choose "bottom" or "top" for flying effect
                speed = 25,                                          -- Max speed is 100 to stick with your current position
                intervals = 35,                                      -- Update intervals in milliseconds
                priority = 10,                                       -- Set marker priority
                timeout = 3000,                                      -- Timeout for animations in milliseconds
                threshold = 1,                                       -- Animate only if cursor moves more than this many lines
                disable_float_win = false,                           -- Disable in floating windows
                enabled_filetypes = nil,                             -- Enable only for specific file types, e.g., { "lua", "vim" }
                disabled_filetypes = { 'Alpha' },                    -- Disable for these file types, ignored if enabled_filetypes is set. e.g., { "TelescopePrompt", "NvimTree" }
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
