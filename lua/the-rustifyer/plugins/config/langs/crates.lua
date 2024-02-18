-- Handles Rust dependencies directly on teh cargo.toml file
--

return {
    tag = 'stable',
    event = { "BufRead Cargo.toml" },
    config = function()
        require('crates').setup()
    end,
}
