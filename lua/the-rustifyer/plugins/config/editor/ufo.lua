-- Configuration for the UFO plugin, which takes care about folding buffer's text lines
--
return {
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { 'treesitter', 'indent' }
            end
        })
    end
}

