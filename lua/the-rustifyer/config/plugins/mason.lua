-- Configuration for the `Mason` plugin
--
local langs = require('the-rustifyer.config.languages')

require('mason').setup({
    ui = {
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
        }
    }
})

require('mason-lspconfig').setup {
    automatic_installation = true,
    -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
    ensure_installed = langs.get_lsp_config()
}

-- After setting up mason-lspconfig you may set up servers via lspconfig
require("lspconfig").rust_analyzer.setup {}
