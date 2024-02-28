-- Treesitter plugin configuration via a custom callback
return {
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'TSInstall', 'TSUpdate' },
    highlight = { enabled = true },
    indent = { enable = true },
    config = function()
        local langs = require('the-rustifyer.core.languages')

        require('nvim-treesitter.configs').setup {
            ensure_installed = langs.get_treesitter_config(),
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
}
