-- Configuration for the plugin that handles the transparency settings
--
return {
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

