-- The core of my Neovim personal setup
--
-- Here is where are defined the most important configuration steps

-- Before all, let's assign our <leader> key
vim.g.mapleader = " "

-- Bring the editor's (Neovim) custom configuration
require('the-rustifyer.config.editor')

-- Initialize the plugin manager and the plugins under <root_path>/.config/nvim/lua/plugins
-- All of the plugins declared in such folder will be automatically detected and loaded by lazy
require('the-rustifyer.config.lazy')

-- Loading the custom remaps after loading the package manager
require('the-rustifyer.config.remaps')

-- Loading the additional configuration to the plugins after discover them
require('the-rustifyer.config.plugins')

-- Setting the colorscheme of the set up
--require('colors')
vim.cmd.colorscheme 'catppuccin'

-- Manually handling required system-wide installations
-- require('the-rustifyer.config.system-wide')

