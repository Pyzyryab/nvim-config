-- Custom VIM autocommands
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

-- Start the JDTLS LSP server when a Java project is detected
autocmd('User', {
    pattern = 'AutostartJDTLS',
    callback = function()
        local root_dir = vim.fn.getcwd()
        local root_pom = vim.fn.glob(root_dir, "pom.xml")

        -- Check for pom.xml under code/ directory
        local code_dir = root_dir .. "code/"
        local code_pom = vim.fn.glob(code_dir, "pom.xml")

        -- Project is Java if either pom.xml exists
        if root_pom ~= "" or code_pom ~= "" then
            -- Looks like a Java project, start jdtls
            vim.cmd("source " .. vim.fn.stdpath('config') .. "/ftplugin/java.lua")
        end
    end
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

-- Cursor position
autocmd({ 'ModeChanged' }, {
    callback = function()
        local current_mode = vim.fn.mode()
        if current_mode == 'n' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#8aa872' })
            vim.fn.sign_define('smoothcursor', { text = '󰝥' })
        elseif current_mode == 'v' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
            vim.fn.sign_define('smoothcursor', { text = '' })
        elseif current_mode == 'V' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
            vim.fn.sign_define('smoothcursor', { text = '' })
        elseif current_mode == '�' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
            vim.fn.sign_define('smoothcursor', { text = '' })
        elseif current_mode == 'i' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#668aab' })
            vim.fn.sign_define('smoothcursor', { text = '' })
        end
    end,
})

--[[ -- listen lsp-progress event and refresh lualine
vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
    group = "lualine_augroup",
    pattern = "LspProgressStatusUpdated",
    callback = require("lualine").refresh,
}) ]]
