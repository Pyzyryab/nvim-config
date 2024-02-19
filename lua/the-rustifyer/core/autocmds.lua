-- Custom VIM autocommands
--

local augroup = vim.api.nvim_create_augroup      -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd      -- Create autocommand
local usercmd = vim.api.nvim_create_user_command -- Create usercommand

--- Allowing 'wqa' to leave even if there's `ToggleTerm` instances active
autocmd({ "TermEnter" }, {
    callback = function()
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

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    group = 'YankHighlight',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
    end
})

-- Remove whitespace on save
autocmd('BufWritePre', {
    pattern = '',
    command = ":%s/\\s\\+$//e"
})

--[[ -- listen lsp-progress event and refresh lualine
vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
    group = "lualine_augroup",
    pattern = "LspProgressStatusUpdated",
    callback = require("lualine").refresh,
}) ]]
