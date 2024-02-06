-- Configuration for the `telescope` Neovim plugin
--
return {
    event = 'VeryLazy',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = function ()
        local noremap_silent = { noremap = true, silent = true };

        -- Telescope
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, noremap_silent)
        vim.keymap.set('n', '<leader>fg', builtin.git_files, noremap_silent)
        vim.keymap.set('n', '<leader>lg', builtin.live_grep, noremap_silent)
        vim.keymap.set('n', '<leader>fb', builtin.buffers, noremap_silent)
        vim.keymap.set('n', '<leader>fc', builtin.commands, noremap_silent)
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, noremap_silent)
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, noremap_silent)

        -- Telescope git picker


        -- Telescope colorscheme preview
        local colorscheme = builtin.colorscheme
        vim.keymap.set('n', '<leader>cs', colorscheme, noremap_silent)
    end,
    file_ignore_patterns = {'.git/'},
    borders = {},
    pickers = {
        colorscheme = {
            enable_preview = true,
            theme = 'dropdown',
            prompt_title = 'Colorschemes',
            --    cwd = '~/.config/nvim/colors/',
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
                preview_cutoff = 10,
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
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
    }
}

-- Loading or handling Telescope plugins
-- require('telescope').load_extension('fzf')

