-- lsp zero plugin setup for autoconfiguring the lsp and cmp engines
-- for the desired languages
--
return {
    branch = 'v3.x',
    config = false,
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
}
