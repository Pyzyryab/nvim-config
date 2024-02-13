-- Configuration for `Mason`, which takes care about install
-- our LSP servers, DAPs, linters and formatters

return {
    lazy = false,
    cmd = 'Mason',
    build = ":MasonUpdate",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
        ensure_installed = {
            -- LSPs
            'rust-analyzer',
            'clangd', -- C/C++
            'ast-grep',
            'asm-lsp', -- Assembly
            'jedi-language-server', -- Python
            'jdtls', -- Java (Eclipse)
            'gopls',
            -- 'golangci-lint-ls',
            'lua-language-server',
            'taplo', -- Markdown
            -- DAPs
            'codelldb',
            'cpptools',
        },

        ui = {
            icons = {
                package_installed = '✓',
                package_pending = '➜',
                package_uninstalled = '✗'
            }
        },
    },
}

