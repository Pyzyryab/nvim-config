-- Plugins for having a terminal integrated within a Neovim session
--
return {
    toggleterm = 'akinsho/toggleterm.nvim',
    {
        'gelguy/wilder.nvim',
        event = 'VeryLazy',
        config = function()
            require('wilder').setup({
                modes = { ':', '/', '?' }
            })
        end,
        build = ':UpdateRemotePlugins'
    },
}
