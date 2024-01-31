-- Tressiter plugin for text highlighting
--
return {
    { 'rush-rs/tree-sitter-asm' },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = true,
        event = 'BufEnter'
    }
}

