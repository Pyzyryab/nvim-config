-- returns a table with all the languages for which I will like to have
-- support between the different tools, specially LSP, formatters...
--
local sys = require('the-rustifyer.core.globals').sys

local M = {}

M.languages = {
    rust = { lsp = 'rust_analyzer', treesitter = 'rust' },
    cpp = { lsp = 'clangd', treesitter = 'cpp' },
    make = { treesitter = 'make' },
    cmake = { lsp = 'neocmake', treesitter = 'cmake' },
    doxygen = { treesitter = 'doxygen' },
    c = { lsp = 'clangd', treesitter = 'c' },

    python = { lsp = 'jedi_language_server', treesitter = 'python' },
    java = { lsp = 'jdtls', treesitter = 'java' },
    kotlin = { lsp = 'kotlin_language_server', treesitter = 'kotlin' },
    zig = { lsp = 'zls', treesitter = 'zig' },
    dart = { treesitter = 'dart' },
    go = { lsp = 'gopls', treesitter = 'go' },
    ruby = {
        -- lsp = 'ruby_ls',
        treesitter = 'ruby'
    },
    lua = { lsp = 'lua_ls', treesitter = 'lua' },

    xml = { treesitter = 'xml' },
    javascript = { treesitter = 'javascript' },
    typescript = { treesitter = 'typescript' },
    html = { treesitter = 'html' },
    css = { treesitter = 'css' },
    scss = { treesitter = 'scss' },
    json = { treesitter = 'json' },
    json5 = { treesitter = 'json5' },

    sql = { treesitter = 'sql' },
    latex = { lsp = 'texlab', treesitter = 'latex' },
    markdown = { lsp = 'golangci_lint_ls', treesitter = 'markdown' },
    toml = { lsp = 'taplo', treesitter = 'toml' },
    yaml = { treesitter = 'yaml' },
    regex = { treesitter = 'regex' },
    llvm = { lsp = 'clangd', treesitter = 'llvm' },
    godot_resource = { treesitter = 'gdscript' },

    vim = { treesitter = 'vim' },
    vimdoc = { treesitter = 'vim' }
}

-- Those below requires node stuff to be installed on Windows, which
-- is not acceptable for me
if not sys.is_windows then
    M.languages.javascript.lsp = 'eslint'
    M.languages.typescript.lsp = 'tsserver'
    M.languages.yaml.lsp = 'yamlls'
    M.languages.html.lsp = 'html'
    M.languages.css.lsp = 'cssls'
    M.languages.scss.lsp = 'cssls'
end

-- The next two functions will be used to retrieve the 'lsp' and 'treesitter'
-- values that are unique keys

function M.get_lsp_config()
    local lsp_configs = {}
    for _, config in pairs(M.languages) do
        if config.lsp ~= nil then
            lsp_configs[config.lsp] = true
        end
    end
    return vim.tbl_keys(lsp_configs)
end

function M.get_treesitter_config()
    local ts_configs = {}
    for _, config in pairs(M.languages) do
        ts_configs[config.treesitter] = true
    end
    return vim.tbl_keys(ts_configs)
end

return M
