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
                    'sql', 'toml', 'yaml', 'llvm', 'gdscript', 'vim', 'kdl', 'dart' },
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
        opts = { mode = "cursor", max_lines = 3 },
    },

    -- Diagnostics
    {
        'folke/trouble.nvim',
        lazy = true,
        cmd = "Trouble",
        event = { 'BufReadPre', 'BufNewFile', },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    }
}
