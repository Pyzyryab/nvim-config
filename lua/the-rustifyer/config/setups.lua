-- Holds plugin specific configurations that must be done after the package manager
-- handles them

-- Telescope
require('telescope').setup({
      pickers = {
        colorscheme = {
          enable_preview = true
        }
      }
})

