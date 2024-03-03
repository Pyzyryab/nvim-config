-- Specs for having shell emulators within Neovim, or by power the Neovim terminal serach/completition
--
return {
    -- Embeeds a terminal(s) (shell emulator(s)) within an active Neovim session
    --
    --I typically don't use thing plugins when I am using a Unix based system,
    --because I have `fg`, but it's fine to have it sometimes when I am on W2
    --and I don't want to have like a million of tabs in Windows Terminal
    {
        'akinsho/toggleterm.nvim',
        event = 'VeryLazy',
        cmd = 'ToggleTerm',
        version = "*",
        config = true,
        opts = {
            size = 15,
            -- open_mapping = '<leader>to',
            insert_mappings = true,
            terminal_mappings = true,
            highlights = {
                Normal = { link = "Normal" },
                NormalNC = { link = "NormalNC" },
                NormalFloat = { link = "NormalFloat" },
                FloatBorder = { link = "FloatBorder" },
                StatusLine = { link = "StatusLine" },
                StatusLineNC = { link = "StatusLineNC" },
                WinBar = { link = "WinBar" },
                WinBarNC = { link = "WinBarNC" },
            },
            -- autochdir = true,
            -- start_in_insert = true,
            winbar = {
                enabled = false,
                -- name_formatter = nil
            },
            float_opts = {
                border = "curved",
            },
            dir = 'git_dir'
        }
    },

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
