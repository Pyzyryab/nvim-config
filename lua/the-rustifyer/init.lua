-- The core of my Neovim personal setup
--
-- Here is where are defined the most important configuration steps

-- First of all, we bring the most inner and important remaps
require('remap')

-- Getting lazy.nvim as the package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setting lazy.nvim
require("lazy").setup(plugins, opts)

