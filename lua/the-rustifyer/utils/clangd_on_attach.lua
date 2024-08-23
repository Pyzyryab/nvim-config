local consts = require('the-rustifyer.core.constants')
local globals = require('the-rustifyer.core.globals')

return {
    force_setup = true,
    on_attach = function()
        local lspconfig = require('lspconfig')
        local lsp_util = require("lspconfig.util")

        -- Unix-like check using 'test -e' command
        -- I mostly use Neovim from a bash-like shell always, so there's no need for Windows specific code
        local clangd_exec = globals.sys.is_windows and 'clangd.EXE' or 'clangd'
        local mbuilt_clangd = vim.fn.expand("~/code/own/llvm-project/build/bin/" .. clangd_exec)
        local cmd = '[ -e "' .. mbuilt_clangd .. '" ] && echo found'
        local result = io.popen(cmd):read("*a")
        local mbuilt_clangd_exists = result:find("found") ~= nil

        local clangd_path = mbuilt_clangd_exists and mbuilt_clangd or clangd_exec
        lspconfig.clangd.setup({
            keys = {
                { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
            },
            root_dir = function(fname)
                return lsp_util.root_pattern(
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
                "--compile_args_from=filesystem",
                "--completion-style=detailed",
                '--enable-config',
                "--function-arg-placeholders",
                "--fallback-style=llvm",
                "--header-insertion=iwyu",
                "--log=verbose",
                "--pch-storage=memory",
                -- "--suggest-missing-includes", -- obsolete from clangd >= 18
                "--pretty",
            },
            init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
                -- TODO: introduce a cfg file reader that is able to find the compile_commands dynamically (not in the root of the project)
            },
        })
    end,
}
