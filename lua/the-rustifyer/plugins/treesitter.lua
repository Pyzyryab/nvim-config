-- Tressiter plugin for text highlighting
--
return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = true,
        event = 'BufEnter'
    }
}

