return {
    'nvim-pack/nvim-spectre',
    event = {'BufReadPre', 'BufNewFile'},
    config = function ()
        require('spectre').setup({ is_block_ui_break = true })
    end
}
