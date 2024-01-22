-- Holds plugin specific configurations that must be done after the package manager
-- handles them

-- Telescope
require('telescope').setup({
    lazy = false,	
    pickers = {
        colorscheme = {
          enable_preview = true
        }
    },
    defaults = {
    	layout_config = {
      	    horizontal = {
        	preview_cutoff = 10,
      	    },
    	},
    },
})

