-- Manually picking the statusline theme that we want to use
--
require("base16-colorscheme")

local evil_lualine_theme = 'evil_lualine'
local base16_theme = 'base16'

require('the-rustifyer.config.plugins.statusline.' .. base16_theme) 
