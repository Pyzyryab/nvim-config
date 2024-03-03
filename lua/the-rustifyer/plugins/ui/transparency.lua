-- Handle editors transparency (requires having transparency enabled on the underlying shell)
--
return {
    'xiyaowong/transparent.nvim',
    event = 'VimEnter',
    config = function()
        require('transparent').setup {
            extra_groups = {
                'Alpha',
                'NeoTreeNormal',
                'NeoTreeNormalNC',
                'NormalFloat',
            },
        }
    end,
}
