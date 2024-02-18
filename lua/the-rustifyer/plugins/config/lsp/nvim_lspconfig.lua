-- nvim-lspconfig
--

local procs = require('the-rustifyer.utils.procedures')

return {
    config = function()
        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_lspconfig()

        lsp_zero.on_attach(function(client, bufnr)
            -- Integration with navic
            if client.server_capabilities.documentSymbolProvider then
                require("nvim-navic").attach(client, bufnr)
            else
                vim.notify('navic wasn\'t unable to attach to: ' .. vim.inspect(client), vim.log.levels.WARN, nil)
            end

            require("clangd_extensions.inlay_hints").setup_autocmd()
            require("clangd_extensions.inlay_hints").set_inlay_hints()

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

        local lspconfig = require('lspconfig')
        require('mason-lspconfig').setup({
            handlers = {
                lsp_zero.default_setup,
                rust_analyzer = lsp_zero.noop, -- The `rustaceanvim` plugin will take care of this
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    lspconfig.lua_ls.setup(lua_opts)
                end,
                jdtls = lsp_zero.noop, -- Exclude jdtls from automatic configuration, we are doing it with the ftplugin way
                clangd = function()
                    lspconfig.clangd.setup({
                        keys = {
                            { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                        },
                        root_dir = function(fname)
                            return require("lspconfig.util").root_pattern(
                                    "compile_commands.json",
                                    "compile_flags.txt",
                                    "Makefile",
                                    "configure.ac",
                                    "configure.in",
                                    "config.h.in",
                                    "meson.build",
                                    "meson_options.txt",
                                    "build.ninja"
                                )(fname) or require("lspconfig.util").find_git_ancestor(fname)
                        end,
                        filetypes = { 'c', 'cc', 'cpp', 'cppm', 'ixx', 'objc', 'cuda', 'proto' },
                        capabilities = {
                            offsetEncoding = { "utf-16" },
                        },
                        cmd = {
                            "clangd",
                            "--background-index",
                            "--clang-tidy",
                            "--header-insertion=iwyu",
                            "--completion-style=detailed",
                            "--function-arg-placeholders",
                            "--fallback-style=llvm",
                        },
                        init_options = {
                            usePlaceholders = true,
                            completeUnimported = true,
                            clangdFileStatus = true,
                        },
                    })
                end,
            },
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
}
