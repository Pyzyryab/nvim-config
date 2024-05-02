-- Specs for having shell emulators within Neovim, or by power the Neovim terminal serach/completition
--
return {
    -- Better Neovim CMD completition and styling
    {
        'gelguy/wilder.nvim',
        event = 'VeryLazy',
        config = function()
            local wilder = require('wilder')
            wilder.setup({
                modes = { ':', '/', '?' },
                enable_cmdline_enter = 0,
            })
            -- Configuration works better in this pluggin via Vim script
            local conf = [[ " Change this to a color which suits your colorscheme
            let s:accent_fg = "#ea4298"

            call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
                \ 'border': 'rounded',
                \ 'highlighter': wilder#basic_highlighter(),
                \ 'highlights': {
                    \   'default': 'Pmenu',
                    \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': s:accent_fg}]),
                    \ },
                    \ 'left': [' ', wilder#popupmenu_devicons(), wilder#popupmenu_buffer_flags()],
                    \ 'right': [' ', wilder#popupmenu_scrollbar()],
                    \ 'pumblend': 20,
                    \ })))  ]]
                    vim.api.nvim_exec(conf, true)
                end,
                build = ':UpdateRemotePlugins',
                no_extra_config = true,
    }
}
