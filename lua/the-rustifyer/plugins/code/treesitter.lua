-- Text highlighting, text objects and text/code context
--
return {
    -- Tressiter plugin for text highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPre', 'BufNewFile' },
        cmd = { 'TSInstall', 'TSUpdate' },
        highlight = { enabled = true },
        indent = { enable = true },
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'rust', 'cpp', 'c', 'cmake', 'make', 'python', 'java', 'go', 'lua', 'html',
                    'sql', 'toml', 'yaml', 'llvm', 'gdscript', 'vim', 'kdl' },
                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,
                prefer_git = true,
                compilers = 'clang',
                highlight = {
                    enable = true,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
                ident = { enable = true },
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
                textobjects = {
                    move = {
                        enable = true,
                        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
                    },
                },
            }

            require('nvim-treesitter.parsers').get_parser_configs().asm = {
                install_info = {
                    url = 'https://github.com/rush-rs/tree-sitter-asm.git',
                    files = { 'src/parser.c' },
                    branch = 'main',
                },
            }
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            -- When in diff mode, we want to use the default
            -- vim text objects c & C instead of the treesitter ones.
            local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
            local configs = require("nvim-treesitter.configs")
            for name, fn in pairs(move) do
                if name:find("goto") == 1 then
                    move[name] = function(q, ...)
                        if vim.wo.diff then
                            local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                            for key, query in pairs(config or {}) do
                                if q == query and key:find("[%]%[][cC]") then
                                    vim.cmd("normal! " .. key)
                                    return
                                end
                            end
                        end
                        return fn(q, ...)
                    end
                end
            end
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { 'BufRead', 'BufNewFile' },
        enabled = true,
        opts = { mode = "cursor", max_lines = 3 },
        keys = {},
    },

    -- Diagnostics
    {
        'folke/trouble.nvim',
        lazy = true,
        event = { 'BufReadPre', 'BufNewFile', },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            position = "bottom", -- position of the list can be: bottom, top, left, right
            height = 10, -- height of the trouble list when position is top or bottom
            width = 50, -- width of the list when position is left or right
            icons = true, -- use devicons for filenames
            mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
            severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
            fold_open = "", -- icon used for open folds
            fold_closed = "", -- icon used for closed folds
            group = true, -- group results by file
            padding = true, -- add an extra new line on top of the list
            cycle_results = true, -- cycle item list when reaching beginning or end of list
            action_keys = { -- key mappings for actions in the trouble list
                -- map to {} to remove a mapping, for example:
                -- close = {},
                close = "q",                                                                  -- close the list
                cancel = "<esc>",                                                             -- cancel the preview and get back to your last window / buffer / cursor
                refresh = "r",                                                                -- manually refresh
                jump = { "<cr>", "<tab>", "<2-leftmouse>" },                                  -- jump to the diagnostic or open / close folds
                open_split = { "<c-x>" },                                                     -- open buffer in new split
                open_vsplit = { "<c-v>" },                                                    -- open buffer in new vsplit
                open_tab = { "<c-t>" },                                                       -- open buffer in new tab
                jump_close = { "o" },                                                         -- jump to the diagnostic and close the list
                toggle_mode = "m",                                                            -- toggle between "workspace" and "document" diagnostics mode
                switch_severity = "s",                                                        -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
                toggle_preview = "P",                                                         -- toggle auto_preview
                hover = "K",                                                                  -- opens a small popup with the full multiline message
                preview = "p",                                                                -- preview the diagnostic location
                open_code_href = "c",                                                         -- if present, open a URI with more information about the diagnostic error
                close_folds = { "zM", "zm" },                                                 -- close all folds
                open_folds = { "zR", "zr" },                                                  -- open all folds
                toggle_fold = { "zA", "za" },                                                 -- toggle fold of current file
                previous = "k",                                                               -- previous item
                next = "j",                                                                   -- next item
                help = "?"                                                                    -- help menu
            },
            multiline = true,                                                                 -- render multi-line messages
            indent_lines = true,                                                              -- add an indent guide below the fold icons
            win_config = { border = "single" },                                               -- window configuration for floating windows. See |nvim_open_win()|.
            auto_open = false,                                                                -- automatically open the list when you have diagnostics
            auto_close = false,                                                               -- automatically close the list when you have no diagnostics
            auto_preview = true,                                                              -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
            auto_fold = false,                                                                -- automatically fold a file trouble list at creation
            auto_jump = { "lsp_definitions" },                                                -- for the given modes, automatically jump if there is only a single result
            include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" }, -- for the given modes, include the declaration of the current symbol in the results
            signs = {
                -- icons / text used for a diagnostic
                error = "",
                warning = "",
                hint = "",
                information = "",
                other = "",
            },
            use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
        }
    },
}
