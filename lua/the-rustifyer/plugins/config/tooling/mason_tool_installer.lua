-- Configuration for automatically download, install and configure
-- LSPs, DAPs, formatters, linters and so on
--

local langs = require('the-rustifyer.core.languages')

return {
    lazy = false,
    event = 'VeryLazy',
    --event = "User CustomMasonLspSetup", -- custom event that gets triggered at a very late instance
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
    opts = {

        ensure_installed = {
            -- LSP servers
            langs.get_lsp_config(),

            -- Formatters

            -- Linters

            -- Others
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 3000, -- 3 second delay
        debounce_hours = 5, -- at least 5 hours between attempts to install/update
    },
    config = function(_, opts)
        local mason_tool_installer = require("mason-tool-installer")
        mason_tool_installer.setup(opts)
        -- As this plugin is lazy loaded, the original event (VimEnter) will never get trigger
        -- That's why I'm forcing the `run_on_start()` trigger
        mason_tool_installer.run_on_start()
    end,
}

