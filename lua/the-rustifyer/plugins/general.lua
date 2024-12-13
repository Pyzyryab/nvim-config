-- General purpose plugins that are typically needed by others, that they are for enhace
-- the capabilities of others or that they are just general purpose plugins
return {

    -- General procedures and functionality library
    { 'nvim-lua/plenary.nvim' },

    -- Better concurrency
    { 'kevinhwang91/promise-async' },

    -- Better vim.ui
    {
        'stevearc/dressing.nvim',
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
    },

    -- LSP, DAP, linters and formatters manager. Provides an easy way to download them from within Neovim
    {
        'williamboman/mason.nvim',
        event = 'VeryLazy',
        cmd = 'Mason',
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                -- LSPs
                -- 'rust-analyzer', -- Disabled, since in my dotfiles installation is already included the RA tool,
                -- and the one embedeed with Mason won't probably fit our toolchain nor the default discovery

                -- 'clangd', -- C/C++ --NOTE Clangd is always installed manually in all of my machines,
                -- because I will have the full LLVM suite in all of them, so I don't want the Mason
                -- version (in almost any case). Uncommented the 'clangd' entry or install it manually
                -- via the GUI of Mason plugin (<leader>om)

                -- 'ast-grep',
                'asm-lsp',              -- Assembly

                'jedi-language-server', -- Python
                'jdtls',                -- Java (Eclipse)
                'gopls',
                'typescript-language-server',
                -- 'golangci-lint-ls',

                'lua-language-server',
                'taplo', -- Markdown
                'cmake-language-server',

                'json-lsp',
                'html-lsp',
                'css-lsp',
                'css-variables-language-server',
                'cssmodules-language-server',
                'eslint-lsp',
                'tailwindcss-language-server',
                'ember-language-server',

                'dockerfile-language-server',
                'docker-compose-language-service',
                'bash-language-server',
                'vacuum', -- OpenAPI

                'vim-language-server',

                -- DAPs
                'codelldb',
                'cpptools',
                'java-debug-adapter',
                'java-test',

                -- formatters
                'asmfmt',
                'prettier',

                -- linters
                'eslint_d',
                'pylint'
            },

            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗'
                }
            },
        },
        config = function(_, opts)
            require('mason').setup(opts)
            local registry = require("mason-registry")

            registry.refresh(function()
                return registry.get_all_package_names()
            end)

            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = registry.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if registry.refresh then
                registry.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end
    },

    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                svelte = { "eslint_d" },
                python = { "pylint" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    }
}
