--'the-rustifyer.plugins.config' The core of my Neovim personal setup
--
-- Here is where are defined the most important configuration steps

-- Before all, let's assign our <leader> key
vim.g.mapleader = " "

-- Bring the editor's (Neovim) custom configuration
require('the-rustifyer.core.editor-config')

-- Initialize the plugin manager to handle the plugins under '~/.config/nvim/lua/the-rustifyer/plugins/<whatever>...'
require('the-rustifyer.core.package-manager')

-- Loading the custom remaps after loading the package manager
require('the-rustifyer.core.remaps')

-- Setting the colorscheme of the set up
vim.cmd.colorscheme 'catppuccin'

-- Manually handling required system-wide installations
-- require('the-rustifyer.config.system-wide')

-- Registering the custom autocommands
require('the-rustifyer.core.autocmds')

