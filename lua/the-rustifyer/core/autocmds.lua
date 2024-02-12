-- Custom VIM autocommands
--

--- Allowing 'wqa' to leave even if there's `ToggleTerm` instances active
vim.api.nvim_create_autocmd({ "TermEnter" }, {
    callback = function()
        print('Raising TermEnter autocommand')
        for _, buffers in ipairs(vim.fn.getbufinfo()) do
            local filetype = vim.api.nvim_buf_get_option(buffers.bufnr, "filetype")
            if filetype == "toggleterm" then
                vim.api.nvim_create_autocmd({ "BufWriteCmd", "FileWriteCmd", "FileAppendCmd" }, {
                    buffer = buffers.bufnr,
                    command = "q!",
                })
            end
        end
    end,
})

