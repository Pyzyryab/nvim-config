-- Fuzzy finder over lists
return {
'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope' },
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim',
    {
        'nvim-telescope/telescope-fzf-native.nvim',
         build ='cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
},
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
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
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
