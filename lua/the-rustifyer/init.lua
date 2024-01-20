-- The core of my Neovim personal setup
--
-- Here is where are defined the most important configuration steps

-- First of all, we bring the most inner and important remaps
require('the-rustifyer.config.remaps')

-- require('the-rustifyer.plugins.lazy')
-- local alpha = require('the-rustifyer.plugins.alpha')

-- local plugins = { alpha }

-- Setting lazy.nvim
require("lazy").setup("plugins")

