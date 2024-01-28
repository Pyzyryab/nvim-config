-- returns a table with all the languages for which I will like to have
-- support between the different tools, specially LSP, formatters...
--

local M = {}

M.languages = {
    rust = { lsp = 'rust_analyzer', treesitter = 'rust' },
    cpp = { lsp = 'clangd', treesitter = 'cpp' },
    make = { lsp = 'cmake', treesitter = 'make' },
    cmake = { lsp = 'neocmake', treesitter = 'cmake' },
    doxygen = { treesitter = 'doxygen' },
    c = { lsp = 'clangd', treesitter = 'c' },

    python = { lsp = 'pyright', treesitter = 'python' },
    java = { lsp = 'jdtls', treesitter = 'java' },
    kotlin = { lsp = 'kotlin_language_server', treesitter = 'kotlin' },
    zig = { lsp = 'zls', treesitter = 'zig' },
    dart = { treesitter = 'dart' },
    go = { lsp = 'golangci_lint_ls', treesitter = 'go' },
    ruby = { lsp = 'ruby_ls', treesitter = 'ruby' },
    lua = { lsp = 'lua_ls', treesitter = 'lua' },

    sql = { lsp = 'sqlls', treesitter = 'sql' },

    javascript = { lsp = 'tsserver', treesitter = 'javascript' },
    typescript = { lsp = 'tsserver', treesitter = 'typescript' },
    yaml = { lsp = 'yamlls', treesitter = 'yaml' },
    xml = { lsp = 'clangd', treesitter = 'xml' },
    html = { lsp = 'html', treesitter = 'html' },
    css = { lsp = 'cssls', treesitter = 'css' },
    scss = { lsp = 'cssls', treesitter = 'scss' },
    json = { lsp = 'jsonls', treesitter = 'json' },
    json5 = { lsp = 'jsonls', treesitter = 'json5' },

    latex = { lsp = 'texlab', treesitter = 'latex' },
    markdown = { lsp = 'golangci_lint_ls', treesitter = 'markdown' },
    toml = { lsp = 'taplo', treesitter = 'toml' },
    matlab = { lsp = 'matlab_ls', treesitter = 'matlab' },
    regex = { treesitter = 'regex' },
    llvm = { lsp = 'clangd', treesitter = 'llvm' },
    godot_resource = { treesitter = 'gdscript' },

    vim = { lsp = 'vimls', treesitter = 'vim' },
    vimdoc = { treesitter = 'vim' }
}

-- The next two functions will be used to retrieve the 'lsp' and 'treesitter'
-- values that are unique keys

function M.get_lsp_config()
    local lsp_configs = {}
        if config.lsp then
            lsp_configs[config.lsp] = true
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
