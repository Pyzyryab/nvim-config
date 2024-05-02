-- Plugin specs for enhace the Java coding sessions
--
return {
    -- TODO: bring the configuration here, since it's possible, instead of having it
    -- isolated on the ftplugin/ dir
    {
        'mfussenegger/nvim-jdtls',
        ft = 'java',
        dependencies = {{'mfussenegger/nvim-dap'}}
    },
}
