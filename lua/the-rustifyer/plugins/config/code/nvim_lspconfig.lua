-- nvim-lspconfig
--

local procs = require('the-rustifyer.utils.procedures')

return {
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
        -- Loading the neoconf plugin BEFORE loading the lsp servers
        require("neoconf").setup({
            -- name of the local settings files
            local_settings = ".nvim-conf.json",
            -- name of the global settings file in your Neovim config directory
            global_settings = "nvim-conf.json",
        })
        -- This is where all the LSP shenanigans will live
        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_lspconfig()

        --- if you want to know more about lsp-zero and mason.nvim
        --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            --lsp_zero.default_keymaps({ buffer = bufnr })
            -- Regular Neovim LSP client keymappings

            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            procs.nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
            procs.nnoremap('gd', vim.lsp.buf.definition, bufopts, "Go to definition")
            procs.nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
            procs.nnoremap('K', vim.lsp.buf.hover, bufopts, "Hover text")
            procs.nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
            procs.nnoremap('<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
            procs.nnoremap('<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
            procs.nnoremap('<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts, "List workspace folders")
            procs.nnoremap('<leader>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
            procs.nnoremap('<leader>rn', vim.lsp.buf.rename, bufopts, "Rename")
            procs.nnoremap('<leader>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
            vim.keymap.set('v', "<leader>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
                { noremap = true, silent = true, buffer = bufnr, desc = "Code actions" })
            procs.nnoremap('<leader>=', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")
        end)

        require('mason-lspconfig').setup({
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            }
        })

        -- technically these are "diagnostic signs"
        -- neovim enables them by default.
        -- here we are just changing them to fancy icons.
        lsp_zero.set_sign_icons({
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = '»'
        })
    end,
    opts = {
        setup = {
            clangd = function(_, opts)
                opts.capabilities.offsetEncoding = { "utf-16" }
            end,
        },
    },
}
