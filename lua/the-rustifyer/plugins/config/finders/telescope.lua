-- Configuration for the `telescope` Neovim plugin
--
return {
    event = 'VeryLazy',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local telescope = require('telescope')

        telescope.load_extension('fzf')

        telescope.setup({
            file_ignore_patterns = { '.git/' },
            borders = {},
            pickers = {
                colorscheme = {
                    enable_preview = true,
                }
            },
            defaults = {
                mappings = {
                    i = {
                        ["<C-u>"] = false
                    },
                },
                layout_config = {
                    horizontal = {
                        preview_cutoff = 0,
                    }
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=always",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--trim"
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                }
            }
        })
    end,
}
