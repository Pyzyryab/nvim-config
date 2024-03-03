-- Handle editors transparency (requires having transparency enabled on the underlying shell)
--
return {
    'xiyaowong/transparent.nvim',
    event = 'UIEnter',
    config = function()
        require('transparent').setup {
            extra_groups = {
                "NeoTreeNormal",
                "NeoTreeNormalNC",
                "NormalFloat",
            },
        }
    end,
}
