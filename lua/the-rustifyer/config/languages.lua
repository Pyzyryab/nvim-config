-- returns a table with all the languages for which I will like to have
-- support between the different tools, specially LSP, formatters...
--

local M = {}

M.languages = {
    rust = { lsp = 'rust_analyzer', treesitter = 'rust' },
    cpp = { lsp = 'clangd', treesitter = 'cpp' },
    make = { lsp = 'cmake', treesitter = 'make' },
    cmake = { lsp = 'neocmake', treesitter = 'cmake' },
    doxygen = { lsp = 'doxygen', treesitter = 'doxygen' },
    c = { lsp = 'ccls', treesitter = 'c' },

    python = { lsp = 'pyright', treesitter = 'python' },
    java = { lsp = 'jdtls', treesitter = 'java' },
    kotlin = { lsp = 'kotlin_language_server', treesitter = 'kotlin' },
    zig = { lsp = 'zls', treesitter = 'zig' },
    dart = { lsp = 'dartls', treesitter = 'dart' },
    go = { lsp = 'gopls', treesitter = 'go' },
    ruby = { lsp = 'solargraph', treesitter = 'ruby' },
    lua = { lsp = 'sumneko_lua', treesitter = 'lua' },

    sql = { lsp = 'sqls', treesitter = 'sql' },
    query = { lsp = 'query', treesitter = 'query' },
    graphql = { lsp = 'graphql', treesitter = 'graphql' },

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
    markdown = { lsp = 'gopls', treesitter = 'markdown' },
    toml = { lsp = 'taplo', treesitter = 'toml' },
    matlab = { lsp = 'matlabls', treesitter = 'matlab' },
    meson = { lsp = 'meson_language_server', treesitter = 'meson' },
    regex = { lsp = 'regex-lsp', treesitter = 'regex' },
    llvm = { lsp = 'clangd', treesitter = 'llvm' },
    godot_resource = { lsp = 'gdscript', treesitter = 'gdscript' },

    vim = { lsp = 'vimls', treesitter = 'vim' },
    vimdoc = { lsp = 'dash', treesitter = 'vim' }
}

function M.get_lsp_config()
    local lsp_configs = {}
    for _, config in pairs(M.languages) do
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
