--'the-rustifyer.plugins.config' The core of my Neovim personal setup
--
-- Here is where are defined the most important configuration steps

-- Before all, let's assign our <leader> key
vim.g.mapleader = " "

-- Initialize the plugin manager and the plugins under <root_path>/.config/nvim/lua/plugins
-- All of the plugins declared in such folder will be automatically detected and loaded by lazy
require('the-rustifyer.core.package-manager')

-- Loading the custom remaps after loading the package manager
require('the-rustifyer.core.remaps')

-- Loading the additional configuration to the plugins after discover them
--require('the-rustifyer.config.plugins')

-- Loading the configuration details of the languages
--require('the-rustifyer.config.languages')

-- Setting the colorscheme of the set up
vim.cmd.colorscheme 'catppuccin'

-- Manually handling required system-wide installations
-- require('the-rustifyer.config.system-wide')

-- Bring the editor's (Neovim) custom configuration
require('the-rustifyer.core.editor-config')

-- Manually making `mason` available at start up time
require('mason').setup({
    ui = {
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
        }
    }
})

