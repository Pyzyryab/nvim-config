-- Configuration for the statusline shown on the bottom of the editor
--
return {
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
                    { -- Setup lsp-progress component
                        function()
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
                                            table.insert(
                                                client_names,
                                                1,
                                                client.name
                                            )
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
