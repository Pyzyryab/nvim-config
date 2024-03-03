-- Plugins for storing and restoring sessions and plugin configurations and states
--
return {
    --- Better UNDO actions, lasting more and with graphical visualization like a git graph
    { 'mbbill/undotree', cmd = 'UndotreeToggle' },

    --- Required for other plugins to store data
    {'kkharji/sqlite.lua', module = 'sqlite' },

    --- Managing Vim sessions
    {
        'folke/persistence.nvim',
        event = "BufReadPre",
        opts = { options = vim.opt.sessionoptions:get() },
    },
}
