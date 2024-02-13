-- Configuration for the `nvim-navic` plugin, which provides a winbar for lsp
-- symbol information and navigation
--
return {
    opts = {
        icons = {
            File          = "󰈙 ",
            Module        = " ",
            Namespace     = "󰌗 ",
            Package       = " ",
            Class         = "󰌗 ",
            Method        = "󰆧 ",
            Property      = " ",
            Field         = " ",
            Constructor   = " ",
            Enum          = "󰕘",
            Interface     = "󰕘",
            Function      = "󰊕 ",
            Variable      = "󰆧 ",
            Constant      = "󰏿 ",
            String        = "󰀬 ",
            Number        = "󰎠 ",
            Boolean       = "◩ ",
            Array         = "󰅪 ",
            Object        = "󰅩 ",
            Key           = "󰌋 ",
            Null          = "󰟢 ",
            EnumMember    = " ",
            Struct        = "󰌗 ",
            Event         = " ",
            Operator      = "󰆕 ",
            TypeParameter = "󰊄 ",
        },
        lsp = {
            auto_attach = true,
            preference = nil,
        },
        highlight = false,
        separator = " > ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = true,
        lazy_update_context = false,
        click = false,
        format_text = function(text)
            return text
        end,
    }
}

