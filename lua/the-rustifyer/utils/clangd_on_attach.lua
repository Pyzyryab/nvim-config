local consts = require('the-rustifyer.core.constants')

return {
    force_setup = true,
    on_attach = function()
        local lspconfig = require('lspconfig')
        local lsp_util = require("lspconfig.util")

        -- Unix-like check using 'test -e' command
        -- I mostly use Neovim from a bash-like shell always, so there's no need for Windows specific code
        local clangd_path = io.popen('which clangd'):read("*a"):match("^[^\n]*")
        vim.notify('Loading CLANGD from autodiscovered path: ' .. clangd_path, vim.log.levels.INFO, nil)
        lspconfig.clangd.setup({
            keys = {
                { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
            },
            root_dir = function(fname)
                return lsp_util.root_pattern(
                    ".clangd",
                    "compile_commands.json",
                    "compile_flags.txt",
                    "Makefile",
                    "configure.ac",
                    "configure.in",
                    "config.h.in",
                    "meson.build",
                    "meson_options.txt",
                    "build.ninja"
                )(fname) or lsp_util.find_git_ancestor(fname)
            end,
            ft = consts.lsp.clangd_fts,
            capabilities = {
                offsetEncoding = { "utf-16" },
            },
            cmd = {
                clangd_path,
                -- '--query-driver="C:/msys64/clang64/bin/clang-*"',
                "--all-scopes-completion",
                "--background-index",
                "--clang-tidy",
                -- "--compile_args_from=filesystem",
                "--completion-parse=always",
                "--completion-style=detailed",
                -- "--cross-file-rename", -- obsolete
                "--debug-origin",
                '--enable-config',
                "--function-arg-placeholders",
                -- "--fallback-style=llvm",
                -- "--folding-ranges", -- obsolete
                "--header-insertion=iwyu",
                "--log=error",
                "--pch-storage=memory",
                -- "--suggest-missing-includes", -- obsolete from clangd >= 18
                "--pretty",
            },
            init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
                -- TODO: introduce a cfg file reader that is able to find the compile_commands dynamically (not in the root of the project)
                --compilationDatabasePath = vim.fn.getcwd() .. "/build",
            },
        })
    end,
}
