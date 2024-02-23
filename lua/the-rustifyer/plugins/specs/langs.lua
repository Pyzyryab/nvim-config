-- Specific plugins for dealing with LSP, DAP, formatters and linter configurations
-- but for specific languages

return {
    -- Rust
    rustaceanvim = 'mrcjkb/rustaceanvim',
    crates = 'saecki/crates.nvim',
    -- C++, C
    clangd_extension = 'p00f/clangd_extensions.nvim',
    -- Cmake
    cmake = 'Civitasv/cmake-tools.nvim',
    -- Java
    nvim_jdtls = { 'mfussenegger/nvim-jdtls', ft = 'java', no_extra_config = true },
}

