-- Configuration for the `spectre` plugin. Find and replace text via multiple pattern matching opts
--
return {
    event = {'BufReadPre', 'BufNewFile'},
    config = function ()
        require('spectre').setup({ is_block_ui_break = true })
    end
}

