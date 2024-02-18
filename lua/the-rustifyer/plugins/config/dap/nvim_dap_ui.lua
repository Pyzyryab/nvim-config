-- Configuration for the debugger UI plugin
--

return {
    opts = {
        mappings = {
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        layouts = {
            {
                elements = {
                    { id = "repl",    size = 0.25 },
                    { id = "console", size = 0.75 },
                },
                size = 0.20,
                position = "bottom",
            },
            {
                elements = {
                    { id = "stacks",      size = 0.10 },
                    { id = "watches",     size = 0.20 },
                    { id = "breakpoints", size = 0.20 },
                    { id = "scopes",      size = 0.40 },
                },
                size = 0.35,
                position = "right",
            },
        },
        controls = {
            enabled = true,
            element = "repl",
        },
        floating = {
            max_height = 0.9,
            max_width = 0.5,
            border = vim.g.border_chars,
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
    },
    config = function (_, opts)
        require('dapui').setup(opts)
    end
}
