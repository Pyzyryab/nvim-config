
-- bottom statusline
return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
        require('lsp-progress').setup({})
        require('lualine').setup({
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            options = {
                icons_enabled = true,
                theme = 'wombat',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = {
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = { fg = "#ff9e64" },
                    },
                    { -- Setup lsp-progress component
                        function()
                            -- listen lsp-progress event and refresh lualine
                            vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
                            vim.api.nvim_create_autocmd("User", {
                                group = "lualine_augroup",
                                pattern = "LspProgressStatusUpdated",
                                callback = require("lualine").refresh,
                            })
                            return require("lsp-progress").progress({
                                max_size = 80,
                                format = function(messages)
                                    local active_clients =
                                        vim.lsp.get_active_clients()
                                    if #messages > 0 then
                                        return table.concat(messages, " ")
                                    end
                                    local client_names = {}
                                    for _, client in ipairs(active_clients) do
                                        if client and client.name ~= "" then
                                            table.insert(client_names, 1, client.name)
                                        end
                                    end
                                    return table.concat(client_names, "  ")
                                end,
                            })
                        end,
                        icon = { "", align = "right" },
                    },
                    "diagnostics",
                },
                lualine_y = { 'encoding', 'fileformat', 'filetype' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        })
    end
}
