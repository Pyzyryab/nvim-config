-- `bufferline plugin configuration'
--
return {
    event = { 'BufRead', 'BufNewFile' },
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
        { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete other buffers" },
        { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete buffers to the right" },
        { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete buffers to the left" },
        { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
        { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
    },
    opts = {
        options = {
            indicator = {
                icon = '▎', -- this should be omitted if indicator style is not 'icon'
                style = 'underline',
            },
            hover = {
                enabled = true,
                delay = 200,
                reveal = { 'close' }
            },
            separator_style = 'slant',
            -- stylua: ignore
            close_command = function(n) require("mini.bufremove").delete(n, false) end,
            -- stylua: ignore
            right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            diagnostics_indicator = function(count, level)
                local icon = level:match("error") and " " or ""
                return " " .. icon .. count
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Project Explorer",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)
        -- Fix bufferline when restoring a session
        vim.api.nvim_create_autocmd("BufAdd", {
            callback = function()
                vim.schedule(function()
                    pcall(nvim_bufferline)
                end)
            end,
        })
        -- Handling the transparency settings
        vim.g.transparent_groups = vim.list_extend(
            vim.g.transparent_groups or {},
            vim.tbl_map(function(v)
                return v.hl_group
            end, vim.tbl_values(require('bufferline.config').highlights))
        )
    end,
}
