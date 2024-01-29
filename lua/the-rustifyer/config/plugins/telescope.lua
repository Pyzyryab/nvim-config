-- Configuration for the `telescope` Neovim plugin

-- Telescope
require('telescope').setup({
    lazy = true,
    file_ignore_patterns = {'.git/'},
    borders = {},
    pickers = {
        colorscheme = {
          enable_preview = true,
          theme = 'dropdown',
          prompt_title = 'Colorschemes',
          cwd = '~/.config/nvim/colors/',
        }
    },
    defaults = {
    	layout_config = {
      	    horizontal = {
        	    preview_cutoff = 10,
            },
    	},
    },
    extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
})

-- Loading or handling Telescope plugins
-- require('telescope').load_extension('fzf')

