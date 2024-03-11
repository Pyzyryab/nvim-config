-- Plugin specs for enhace the Java coding sessions
--
return {
    -- TODO: add and configure the Maven plugin
    -- TODO: bring the configuration here, since it's possible, instead of having it
    -- isolated on the ftplugin/ dir
    {
        'mfussenegger/nvim-jdtls',
        ft = 'java'
    },

    -- Maven goals from within Neovim
    {
        'eatgrass/maven.nvim',
        cmd = { 'Maven', 'MavenExec' },
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('maven').setup({
                executable = 'mvn', -- `mvn` should be in your `PATH`, or the path to the maven exectable
                cwd = nil, -- work directory, default to `vim.fn.getcwd()`
                settings = nil, -- specify the settings file or use the default settings
                commands = { -- add custom goals to the command list
                    { cmd = { 'clean', 'compile' }, desc = 'clean then compile' },
                    { cmd = { 'clean', 'install' }, desc = 'clean then install' },
                    { cmd = { 'clean', 'package' }, desc = 'clean then package' },
                },
            })
        end
    },
}

