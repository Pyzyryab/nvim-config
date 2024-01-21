-- The core of my Neovim personal setup
--
-- Here is where are defined the most important configuration steps

-- First of all, we bring the most inner and important remaps
require('the-rustifyer.config.remaps')

-- Initialize the plugin manager and the plugins under <root_path>/.config/nvim/lua/plugins
-- All of the plugins declared in such folder will be automatically detected and loaded by lazy
require('the-rustifyer.config.lazy')
