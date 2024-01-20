-- custom configuration for the `Alpha` Neovim plugin, which is
-- the one responsible for loading a nice and neat UI at the
-- start of Neovim

return {
  {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  init = false,
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
   _________  ___  ___  _______           ________  ___  ___  ________  _________  ___  ________ ___    ___ _______   ________    
  |\___   ___|\  \|\  \|\  ___ \         |\   __  \|\  \|\  \|\   ____\|\___   ___|\  \|\  _____|\  \  /  /|\  ___ \ |\   __  \    
  \|___ \  \_\ \  \\\  \ \   __/|        \ \  \|\  \ \  \\\  \ \  \___|\|___ \  \_\ \  \ \  \__/\ \  \/  / \ \   __/|\ \  \|\  \   
       \ \  \ \ \   __  \ \  \_|/__       \ \   _  _\ \  \\\  \ \_____  \   \ \  \ \ \  \ \   __\\ \    / / \ \  \_|/_\ \   _  _\  
        \ \  \ \ \  \ \  \ \  \_|\ \       \ \  \\  \\ \  \\\  \|____|\  \   \ \  \ \ \  \ \  \_| \/  /  /   \ \  \_|\ \ \  \\  \| 
         \ \__\ \ \__\ \__\ \_______\       \ \__\\ _\\ \_______\____\_\  \   \ \__\ \ \__\ \__\__/  / /      \ \_______\ \__\\ _\ 
          \|__|  \|__|\|__|\|_______|        \|__|\|__|\|_______|\_________\   \|__|  \|__|\|__|\___/ /        \|_______|\|__|\|__|
                                                                \|_________|                   \|___|/                                                                                                                                                               
    ]]

    dashboard.section.header.val = vim.split(logo, "\n")
    -- stylua: ignore
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file",       "<cmd> Telescope find_files <cr>"),
      dashboard.button("n", " " .. " New file",        "<cmd> ene <BAR> startinsert <cr>"),
      dashboard.button("r", " " .. " Recent files",    "<cmd> Telescope oldfiles <cr>"),
      dashboard.button("g", " " .. " Find text",       "<cmd> Telescope live_grep <cr>"),
      dashboard.button("c", " " .. " Config",          "<cmd> lua require('lazyvim.util').telescope.config_files()() <cr>"),
      dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
      dashboard.button("x", " " .. " Lazy Extras",     "<cmd> LazyExtras <cr>"),
      dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
      dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
}
