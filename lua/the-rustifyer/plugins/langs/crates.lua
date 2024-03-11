-- Handles Rust dependencies directly on teh cargo.toml file
--

return {
    -- TODO: merge the configuration on a Rust file with rustaceanvim
    'saecki/crates.nvim',
    tag = 'stable',
    event = { "BufRead Cargo.toml" },
    config = function()
        require('crates').setup()
    end,
}
