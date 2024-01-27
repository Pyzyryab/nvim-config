-- Genaral UI components that doesn't deserves a module on their own
return { 
  -- nui (general purpose library required by other components)
  { 'MunifTanjim/nui.nvim' },

  -- Most popular set of icons for the visual plugins of Neovim
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- Better `vim.ui` 
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  }
}
